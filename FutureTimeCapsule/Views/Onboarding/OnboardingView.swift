import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    PageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .ignoresSafeArea(edges: .top)
            
            Button(
                currentPage < pages.count - 1
                ? "Next"
                : "Get Started"
            ) {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    hasCompletedOnboarding = true
                }
            }
            .padding(.bottom)
        }
        .background(
            Constants.Colors.background
                .ignoresSafeArea()
        )
    }
    
    private let pages: [Page] = [
        Page(
            icon: "bg1",
            title: "Dreams Are Taking Shape",
            description: "Your thoughts are gently traveling into the future."
        ),
        Page(
            icon: "bg2",
            title: "Sealed by Time",
            description: "Some messages are meant for tomorrow."
        ),
        Page(
            icon: "bg3",
            title: "Open When the Time Comes",
            description: "Every dream has its day."
        )
    ]
}

struct Page {
    let icon: String
    let title: String
    let description: String
}

struct PageView: View {
    let page: Page
    
    var body: some View {
        VStack(spacing: 10) {
            Image(page.icon)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            Text(page.title)
                .font(.title)
                .foregroundStyle(Constants.Colors.pink)

            Text(page.description)
                .font(.body)
                .foregroundStyle(Constants.Colors.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .ignoresSafeArea(edges: .top)
    }
}


#Preview {
    OnboardingView()
}

