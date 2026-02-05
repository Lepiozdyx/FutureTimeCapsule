import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showCreateSheet = false
    @State private var storageManager = StorageManager.shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                SealedCapsulesView(showCreateSheet: $showCreateSheet)
                    .tag(0)
                
                OpenedCapsulesView(showCreateSheet: $showCreateSheet)
                    .tag(1)
                
                StatsView(showCreateSheet: $showCreateSheet)
                    .tag(2)
            }
            .tabViewStyle(.automatic)
            .toolbar(.hidden, for: .tabBar)
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .background(Constants.Colors.background.ignoresSafeArea())
        .sheet(isPresented: $showCreateSheet) {
            CreateCapsuleView()
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarItem(
                icon: "capsule.fill",
                title: "Sealed",
                isSelected: selectedTab == 0,
                color: Constants.Colors.blue
            ) {
                selectedTab = 0
            }
            
            TabBarItem(
                icon: "capsule.portrait.fill",
                title: "Opened",
                isSelected: selectedTab == 1,
                color: Constants.Colors.pink
            ) {
                selectedTab = 1
            }
            
            TabBarItem(
                icon: "chart.bar.fill",
                title: "Stats",
                isSelected: selectedTab == 2,
                color: Constants.Colors.yellow
            ) {
                selectedTab = 2
            }
        }
        .frame(height: 80)
        .background(Constants.Colors.pink)
        .clipShape(RoundedRectangle(cornerRadius: 0))
    }
}

struct TabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Constants.Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? color : .white.opacity(0.6))
                
                Text(title)
                    .font(Constants.Fonts.caption)
                    .foregroundStyle(isSelected ? color : .white.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainTabView()
}
