
import SwiftUI

@available(iOS 14.0, *)
struct SecureAccessView: View {
    
    @EnvironmentObject var dataManager: GameDataManager
    @StateObject private var accessManager = SecureAccessManager()
    @State private var grantedURL: URL?
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            if grantedURL == nil && !isLoading {
                GamingDashboardView()
                    .environmentObject(dataManager)
            }
            if let url = grantedURL {
                SecureWebView(url: url, loading: $isLoading)
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true)
            }
            if isLoading {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.8)
                    )
            }
        }
        .onReceive(accessManager.$state) { state in
            switch state {
            case .verifying:
                isLoading = true
            case .authorized(_, let url):
                grantedURL = url
                isLoading = false
            case .fallback:
                grantedURL = nil
                isLoading = false
            case .idle:
                break
            }
        }
        .onAppear {
            isLoading = true
            accessManager.start()
        }
    }
}
