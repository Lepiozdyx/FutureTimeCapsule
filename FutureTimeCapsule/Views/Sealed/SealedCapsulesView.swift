import SwiftUI

struct SealedCapsulesView: View {
    @Binding var showCreateSheet: Bool
    @State private var storageManager = StorageManager.shared
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: Constants.Spacing.m), count: 2)
    
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
                            .offset(y: -10)
                    }
                    
                    if storageManager.sealedCapsules.isEmpty {
                        Spacer()
                        EmptyStateView(
                            title: "No sealed capsules yet.", 
                            subtitle: "Create your first time capsule!"
                        )
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: Constants.Spacing.l) {
                                ForEach(storageManager.sealedCapsules) { capsule in
                                    CapsuleCardView(capsule: capsule)
                                }
                            }
                            .padding(.horizontal, Constants.Spacing.s)
                            .padding(.vertical, Constants.Spacing.m)
                        }
                        .scrollIndicators(.hidden)
                        .contentMargins(.bottom, 60, for: .scrollContent)
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
                        .font(Constants.Fonts.body)
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    SealedCapsulesViewPreview(isEmpty: false)
}

private struct SealedCapsulesViewPreview: View {
    @State private var showCreateSheet = false
    let isEmpty: Bool
    
    var body: some View {
        SealedCapsulesView(showCreateSheet: $showCreateSheet)
            .onAppear {
                if !isEmpty {
                    let mockCapsules = [
                        FutureCapsule(
                            title: "My Dream",
                            message: "Become an iOS developer",
                            imageData: nil,
                            dreamType: .dream,
                            aboutType: .myself,
                            openDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!
                        ),
                        FutureCapsule(
                            title: "Love Goal",
                            message: "Find true love",
                            imageData: nil,
                            dreamType: .love,
                            aboutType: .partner,
                            openDate: Calendar.current.date(byAdding: .year, value: 1, to: Date())!
                        ),
                        FutureCapsule(
                            title: "Ready Capsule",
                            message: "This is ready to open",
                            imageData: nil,
                            dreamType: .goal,
                            aboutType: .myself,
                            openDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                        )
                    ]
                    mockCapsules.forEach { StorageManager.shared.addCapsule($0) }
                }
            }
    }
}
