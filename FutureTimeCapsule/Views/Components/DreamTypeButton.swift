import SwiftUI

struct DreamTypeButton: View {
    let dreamType: DreamType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: Constants.Spacing.xs) {
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(dreamType.color)
                        .frame(width: Constants.Components.iconSize, height: Constants.Components.iconSize)
                    
                    Image(dreamType.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .overlay {
                    if isSelected {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                            .frame(width: Constants.Components.iconSize, height: Constants.Components.iconSize)
                    }
                }
            }
            
            Text(dreamType.displayName)
                .font(Constants.Fonts.caption)
                .foregroundStyle(isSelected ? dreamType.color : .white)
        }
    }
}
