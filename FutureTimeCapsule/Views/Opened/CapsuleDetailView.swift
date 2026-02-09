import SwiftUI

struct CapsuleDetailView: View {
    let capsuleId: UUID
    @State private var storageManager = StorageManager.shared
    @State private var showShareSheet = false
    
    private var capsule: FutureCapsule? {
        storageManager.capsules.first { $0.id == capsuleId }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
    
    private var shareText: String {
        guard let capsule = capsule else { return "" }
        let statusText = capsule.fulfillmentStatus?.displayName ?? "Not set"
        return """
        \(capsule.title)
        
        \(capsule.message)
        
        Type: \(capsule.dreamType.displayName)
        Created: \(dateFormatter.string(from: capsule.createdDate))
        Opened: \(capsule.openedDate.map { dateFormatter.string(from: $0) } ?? "Not opened")
        Status: \(statusText)
        """
    }
    
    var body: some View {
        Group {
            if let capsule = capsule {
                ScrollView {
                    VStack(spacing: Constants.Spacing.l) {
                        if let imageData = capsule.imageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: Constants.Components.photoFrameSize, height: Constants.Components.photoFrameSize)
                                .clipShape(Circle())
                        }
                        
                        Text(capsule.title)
                            .font(Constants.Fonts.largeTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        
                        Text(capsule.message)
                            .font(Constants.Fonts.body)
                            .foregroundStyle(.white)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Constants.Spacing.m)
                        
                        HStack(spacing: Constants.Spacing.s) {
                            Image(capsule.dreamType.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: Constants.Components.iconSize)
                            
                            VStack(alignment: .leading, spacing: Constants.Spacing.xs) {
                                Text("Created: \(dateFormatter.string(from: capsule.createdDate))")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(.white)
                                
                                if let openedDate = capsule.openedDate {
                                    Text("Opened: \(dateFormatter.string(from: openedDate))")
                                        .font(Constants.Fonts.caption)
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Spacer()
                            
                            Text(capsule.aboutType.displayName)
                                .font(Constants.Fonts.caption)
                                .foregroundStyle(.white)
                                .padding(.horizontal, Constants.Spacing.s)
                                .padding(.vertical, Constants.Spacing.xs)
                                .background(Constants.Colors.pink)
                                .clipShape(Capsule())
                        }
                        .padding(.horizontal, Constants.Spacing.m)
                        .padding(.vertical, Constants.Spacing.m)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                .fill(Constants.Colors.card)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                        .stroke(Constants.Colors.pink, lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, Constants.Spacing.m)
                        
                        VStack(spacing: Constants.Spacing.m) {
                            HStack {
                                Text("Status:")
                                    .font(Constants.Fonts.headline)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                if let status = capsule.fulfillmentStatus {
                                    HStack(spacing: 4) {
                                        Text(status.emoji)
                                        Text(status.displayName)
                                            .font(Constants.Fonts.body)
                                    }
                                    .font(Constants.Fonts.headline)
                                    .foregroundStyle(status == .fulfilled ? Constants.Colors.green : .red)
                                    
                                    Button {
                                        toggleStatus()
                                    } label: {
                                        Image(systemName: "arrow.clockwise.circle.fill")
                                            .font(Constants.Fonts.headline)
                                            .foregroundStyle(Constants.Colors.pink)
                                    }
                                }
                            }
                            
                            if capsule.fulfillmentStatus == nil {
                                HStack(spacing: Constants.Spacing.m) {
                                    Button {
                                        updateStatus(.fulfilled)
                                    } label: {
                                        HStack {
                                            Text("✅")
                                            Text("Fulfilled")
                                                .font(Constants.Fonts.body)
                                        }
                                        .font(Constants.Fonts.headline)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, Constants.Spacing.m)
                                        .background(Constants.Colors.green)
                                        .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.l))
                                    }
                                    
                                    Button {
                                        updateStatus(.notFulfilled)
                                    } label: {
                                        HStack {
                                            Text("❌")
                                            Text("Not Fulfilled")
                                                .font(Constants.Fonts.body)
                                        }
                                        .font(Constants.Fonts.headline)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, Constants.Spacing.m)
                                        .background(.red)
                                        .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.l))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, Constants.Spacing.m)
                        .padding(.vertical, Constants.Spacing.m)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                .fill(Constants.Colors.card)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                        .stroke(Constants.Colors.pink, lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, Constants.Spacing.m)
                        
                        CustomButton(title: "Share") {
                            showShareSheet = true
                        }
                        .padding(.horizontal, Constants.Spacing.m)
                        .padding(.bottom, Constants.Spacing.xl)
                    }
                    .padding(.top, Constants.Spacing.l)
                }
                .background(Constants.Colors.background.ignoresSafeArea())
                .navigationTitle("Opened Capsule")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Constants.Colors.pink, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(items: [shareText])
                }
            } else {
                Text("Capsule not found")
                    .foregroundStyle(.white)
            }
        }
    }
    
    private func updateStatus(_ status: FulfillmentStatus) {
        guard var updatedCapsule = capsule else { return }
        updatedCapsule.fulfillmentStatus = status
        storageManager.updateCapsule(updatedCapsule)
    }
    
    private func toggleStatus() {
        guard let capsule = capsule,
              let currentStatus = capsule.fulfillmentStatus else { return }
        let newStatus: FulfillmentStatus = currentStatus == .fulfilled ? .notFulfilled : .fulfilled
        updateStatus(newStatus)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    NavigationStack {
        CapsuleDetailViewPreview(hasFulfillmentStatus: false)
    }
}

private struct CapsuleDetailViewPreview: View {
    let hasFulfillmentStatus: Bool
    let isFulfilled: Bool
    let mockCapsuleId = UUID()
    
    init(hasFulfillmentStatus: Bool, isFulfilled: Bool = false) {
        self.hasFulfillmentStatus = hasFulfillmentStatus
        self.isFulfilled = isFulfilled
    }
    
    var body: some View {
        CapsuleDetailView(capsuleId: mockCapsuleId)
            .onAppear {
                let mockCapsule = FutureCapsule(
                    id: mockCapsuleId,
                    title: "My Dream Career",
                    message: "I want to become a successful iOS developer and create amazing apps that help people in their daily lives.",
                    imageData: UIImage(systemName: "star.fill")?.pngData(),
                    dreamType: .dream,
                    aboutType: .myself,
                    openDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
                    createdDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                    openedDate: Date(),
                    fulfillmentStatus: hasFulfillmentStatus ? (isFulfilled ? .fulfilled : .notFulfilled) : nil
                )
                StorageManager.shared.addCapsule(mockCapsule)
            }
    }
}
