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
        VStack(spacing: Constants.Spacing.s) {
            ZStack {
                Circle()
                    .fill(capsule.dreamType.color)
                    .frame(width: Constants.Components.iconSize, height: Constants.Components.iconSize)
                
                Image(capsule.dreamType.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            
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
//                        .clipShape(Capsule())
                }
                .padding(.top, Constants.Spacing.xs)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Constants.Spacing.m)
    }
    
    private func openCapsule() {
        var updatedCapsule = capsule
        updatedCapsule.openedDate = Date()
        storageManager.updateCapsule(updatedCapsule)
    }
}
