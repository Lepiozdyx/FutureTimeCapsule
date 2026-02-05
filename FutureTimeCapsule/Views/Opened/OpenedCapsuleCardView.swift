import SwiftUI

struct OpenedCapsuleCardView: View {
    let capsule: FutureCapsule
    
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
            
            if let openedDate = capsule.openedDate {
                Text("Opened on \(dateFormatter.string(from: openedDate))")
                    .font(Constants.Fonts.caption)
                    .foregroundStyle(Constants.Colors.yellow)
            }
            
            if let status = capsule.fulfillmentStatus {
                HStack(spacing: 4) {
                    Text(status.emoji)
                    Text(status.displayName)
                        .font(Constants.Fonts.caption)
                }
                .foregroundStyle(status == .fulfilled ? Constants.Colors.green : .red)
            } else {
                Text("❌ Not Fulfilled")
                    .font(Constants.Fonts.caption)
                    .foregroundStyle(.red)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Constants.Spacing.m)
    }
}
