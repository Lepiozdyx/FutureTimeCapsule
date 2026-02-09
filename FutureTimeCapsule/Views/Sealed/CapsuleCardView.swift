import SwiftUI

struct CapsuleCardView: View {
    let capsule: FutureCapsule
    @State private var storageManager = StorageManager.shared
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: Constants.Spacing.xs) {
            Image(capsule.dreamType.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Components.iconSize)
            
            Text(capsule.title)
                .font(Constants.Fonts.headline)
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Text(capsule.aboutType.displayName)
                .font(Constants.Fonts.caption)
                .foregroundStyle(.white.opacity(0.7))
            
            Text(dateFormatter.string(from: capsule.openDate))
                .font(Constants.Fonts.caption)
                .foregroundStyle(capsule.dreamType.color)
            
            if capsule.isReadyToOpen {
                Button {
                    openCapsule()
                } label: {
                    Text("Open Capsule")
                        .font(Constants.Fonts.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, Constants.Spacing.m)
                        .padding(.vertical, Constants.Spacing.xs)
                        .background(Constants.Colors.pink)
                        .clipShape(Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func openCapsule() {
        var updatedCapsule = capsule
        updatedCapsule.openedDate = Date()
        storageManager.updateCapsule(updatedCapsule)
    }
}

#Preview("Sealed Capsule") {
    ZStack {
        Constants.Colors.background
            .ignoresSafeArea()
        
        CapsuleCardView(capsule: FutureCapsule(
            title: "My Dream",
            message: "I want to become a successful iOS developer",
            imageData: nil,
            dreamType: .dream,
            aboutType: .myself,
            openDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!
        ))
    }
}

#Preview("Ready to Open") {
    ZStack {
        Constants.Colors.background
            .ignoresSafeArea()
        
        CapsuleCardView(capsule: FutureCapsule(
            title: "Learn SwiftUI",
            message: "Master SwiftUI in 6 months",
            imageData: nil,
            dreamType: .goal,
            aboutType: .myself,
            openDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ))
    }
}
