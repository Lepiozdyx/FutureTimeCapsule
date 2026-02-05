import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(Constants.Fonts.body)
            .foregroundStyle(.white)
            .padding(.horizontal, Constants.Spacing.m)
            .frame(height: Constants.Components.textFieldSize)
            .background(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                    .fill(Color(hex: "2A1F3D"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                    .stroke(Constants.Colors.pink, lineWidth: 1.5)
            )
    }
}
