import SwiftUI

struct InfoBanner: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(Constants.Fonts.body)
            .foregroundStyle(.white)
            .padding(.horizontal, Constants.Spacing.m)
            .padding(.vertical, Constants.Spacing.m)
            .frame(maxWidth: .infinity)
            .background(Constants.Colors.blue)
            .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.l))
            .padding(.horizontal, Constants.Spacing.m)
    }
}
