import SwiftUI

struct SealedCapsulesView: View {
    @Binding var showCreateSheet: Bool
    @State private var storageManager = StorageManager.shared
    
    private let columns = [
        GridItem(.flexible(), spacing: Constants.Spacing.m),
        GridItem(.flexible(), spacing: Constants.Spacing.m)
    ]
    
    private var hasReadyToOpen: Bool {
        storageManager.sealedCapsules.contains { $0.isReadyToOpen }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background.ignoresSafeArea()
                
                VStack(spacing: Constants.Spacing.m) {
                    if hasReadyToOpen {
                        InfoBanner(message: "The time has come. Open your capsule.")
                            .padding(.top, Constants.Spacing.s)
                    }
                    
                    if storageManager.sealedCapsules.isEmpty {
                        Spacer()
                        EmptyStateView(
                            message: "No sealed capsules yet.\nCreate your first time capsule!"
                        )
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: Constants.Spacing.l) {
                                ForEach(storageManager.sealedCapsules) { capsule in
                                    CapsuleCardView(capsule: capsule)
                                }
                            }
                            .padding(.horizontal, Constants.Spacing.m)
                            .padding(.vertical, Constants.Spacing.m)
                        }
                    }
                }
            }
            .navigationTitle("Sealed Capsules")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Constants.Colors.pink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateSheet = true
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                            Text("Create")
                        }
                        .font(Constants.Fonts.headline)
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(Constants.Fonts.body)
            .foregroundStyle(.white.opacity(0.6))
            .multilineTextAlignment(.center)
            .padding(.horizontal, Constants.Spacing.xl)
    }
}
