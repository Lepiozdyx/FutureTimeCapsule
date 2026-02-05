import SwiftUI

struct OpenedCapsulesView: View {
    @Binding var showCreateSheet: Bool
    @State private var storageManager = StorageManager.shared
    
    private let columns = [
        GridItem(.flexible(), spacing: Constants.Spacing.m),
        GridItem(.flexible(), spacing: Constants.Spacing.m)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background.ignoresSafeArea()
                
                if storageManager.openedCapsules.isEmpty {
                    EmptyStateView(
                        message: "No opened capsules yet.\nWait for your sealed capsules to be ready!"
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: Constants.Spacing.l) {
                            ForEach(storageManager.openedCapsules) { capsule in
                                NavigationLink {
                                    CapsuleDetailView(capsuleId: capsule.id)
                                } label: {
                                    OpenedCapsuleCardView(capsule: capsule)
                                }
                            }
                        }
                        .padding(.horizontal, Constants.Spacing.m)
                        .padding(.vertical, Constants.Spacing.m)
                    }
                }
            }
            .navigationTitle("Opened Capsules")
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
