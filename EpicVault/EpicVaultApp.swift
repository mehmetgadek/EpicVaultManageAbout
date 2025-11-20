

import SwiftUI

@available(iOS 14.0, *)
@main
struct EpicVaultApp: App {
    @StateObject var dataManager = GameDataManager()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                SecureAccessView()
                    .environmentObject(dataManager)
            }
        }
    }
}
