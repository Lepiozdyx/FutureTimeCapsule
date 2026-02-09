import SwiftUI

@main
struct FutureTimeCapsuleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentSourceView()
        }
    }
}
