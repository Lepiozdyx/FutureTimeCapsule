import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showCreateSheet = false
    @State private var storageManager = StorageManager.shared
    
    var body: some View {
        Group {
            switch selectedTab {
            case 0:
                SealedCapsulesView(showCreateSheet: $showCreateSheet)
            case 1:
                OpenedCapsulesView(showCreateSheet: $showCreateSheet)
            case 2:
                StatsView(showCreateSheet: $showCreateSheet)
            default:
                SealedCapsulesView(showCreateSheet: $showCreateSheet)
            }
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
        }
        .background(Constants.Colors.background.ignoresSafeArea())
        .sheet(isPresented: $showCreateSheet) {
            CreateCapsuleView()
                .presentationDragIndicator(.visible)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarItem(
                icon: .pill,
                title: "Sealed",
                isSelected: selectedTab == 0,
                color: Constants.Colors.blue
            ) {
                selectedTab = 0
            }
            
            TabBarItem(
                icon: .openpill,
                title: "Opened",
                isSelected: selectedTab == 1,
                color: Constants.Colors.blue
            ) {
                selectedTab = 1
            }
            
            TabBarItem(
                icon: .chart,
                title: "Stats",
                isSelected: selectedTab == 2,
                color: Constants.Colors.blue
            ) {
                selectedTab = 2
            }
        }
        .frame(height: 49)
        .background(Constants.Colors.pink)
    }
}

struct TabBarItem: View {
    let icon: ImageResource
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Constants.Spacing.xs) {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26)
                    .foregroundStyle(isSelected ? color : Constants.Colors.yellow.opacity(0.9))
                
                Text(title)
                    .font(Constants.Fonts.caption)
                    .foregroundStyle(isSelected ? color : Constants.Colors.yellow.opacity(0.9))
            }
            .animation(.easeInOut(duration: 0.15), value: isSelected)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    MainTabView()
}
