import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    init() {
        Task {
            await NotificationManager.shared.requestPermission()
        }
    }
    
    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
