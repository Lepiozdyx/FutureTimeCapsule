import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Constants.Fonts.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.Components.primaryButtonSize)
                .background(Constants.Colors.pink)
                .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.l))
        }
    }
}
