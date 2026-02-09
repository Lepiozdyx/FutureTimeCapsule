import SwiftUI

struct OpenedCapsulesView: View {
    @Binding var showCreateSheet: Bool
    @State private var storageManager = StorageManager.shared
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: Constants.Spacing.m), count: 2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background.ignoresSafeArea()
                
                if storageManager.openedCapsules.isEmpty {
                    EmptyStateView(
                        title: "No opened capsules yet", 
                        subtitle: "Wait for your sealed capsules to be ready"
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
                        .padding(.horizontal, Constants.Spacing.s)
                        .padding(.vertical, Constants.Spacing.m)
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(.bottom, 60, for: .scrollContent)
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
                        .font(Constants.Fonts.body)
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    OpenedCapsulesViewPreview(isEmpty: false)
}

private struct OpenedCapsulesViewPreview: View {
    @State private var showCreateSheet = false
    let isEmpty: Bool
    
    var body: some View {
        OpenedCapsulesView(showCreateSheet: $showCreateSheet)
            .onAppear {
                if !isEmpty {
                    let mockCapsules = [
                        FutureCapsule(
                            title: "My Dream",
                            message: "Become an iOS developer",
                            imageData: nil,
                            dreamType: .dream,
                            aboutType: .myself,
                            openDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
                            openedDate: Date(),
                            fulfillmentStatus: .fulfilled
                        ),
                        FutureCapsule(
                            title: "Learn Piano",
                            message: "Master piano",
                            imageData: nil,
                            dreamType: .goal,
                            aboutType: .myself,
                            openDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                            openedDate: Date(),
                            fulfillmentStatus: .notFulfilled
                        ),
                        FutureCapsule(
                            title: "Family Time",
                            message: "Spend more time with family",
                            imageData: nil,
                            dreamType: .love,
                            aboutType: .parent,
                            openDate: Calendar.current.date(byAdding: .month, value: -3, to: Date())!,
                            openedDate: Date(),
                            fulfillmentStatus: nil
                        )
                    ]
                    mockCapsules.forEach { StorageManager.shared.addCapsule($0) }
                }
            }
    }
}
