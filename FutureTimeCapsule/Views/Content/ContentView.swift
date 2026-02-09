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
                .preferredColorScheme(.dark)
        } else {
            OnboardingView()
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
