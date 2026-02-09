import SwiftUI

struct OpenedCapsuleCardView: View {
    let capsule: FutureCapsule
    
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
                .frame(height: Constants.Components.iconSize)
            
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
    }
}

#Preview("Fulfilled") {
    ZStack {
        Constants.Colors.background
            .ignoresSafeArea()
        
        OpenedCapsuleCardView(capsule: FutureCapsule(
            title: "My Dream",
            message: "Become a successful developer",
            imageData: nil,
            dreamType: .dream,
            aboutType: .myself,
            openDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
            openedDate: Date(),
            fulfillmentStatus: .fulfilled
        ))
    }
}

#Preview("Not Fulfilled") {
    ZStack {
        Constants.Colors.background
            .ignoresSafeArea()
        
        OpenedCapsuleCardView(capsule: FutureCapsule(
            title: "Learn Piano",
            message: "Master piano in one year",
            imageData: nil,
            dreamType: .goal,
            aboutType: .myself,
            openDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
            openedDate: Date(),
            fulfillmentStatus: .notFulfilled
        ))
    }
}

#Preview("No Status") {
    ZStack {
        Constants.Colors.background
            .ignoresSafeArea()
        
        OpenedCapsuleCardView(capsule: FutureCapsule(
            title: "Family Love",
            message: "Spend more time with family",
            imageData: nil,
            dreamType: .love,
            aboutType: .parent,
            openDate: Calendar.current.date(byAdding: .month, value: -3, to: Date())!,
            openedDate: Date(),
            fulfillmentStatus: nil
        ))
    }
}
