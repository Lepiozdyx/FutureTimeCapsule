import SwiftUI

struct DreamTypeButton: View {
    let dreamType: DreamType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: Constants.Spacing.xs) {
            Button(action: action) {
                Image(dreamType.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.Components.iconSize)
                    .overlay {
                        if isSelected {
                            Circle()
                                .stroke(Constants.Colors.pink, lineWidth: 2)
                                .frame(width: Constants.Components.iconSize, height: Constants.Components.iconSize)
                        }
                    }
            }
            
            Text(dreamType.displayName)
                .font(Constants.Fonts.body)
                .foregroundStyle(isSelected ? dreamType.color : .white)
        }
    }
}

#Preview {
    DreamTypeButton(dreamType: DreamType.love, isSelected: true, action: {})
}
