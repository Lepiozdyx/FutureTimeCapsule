import SwiftUI

struct EmptyStateView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: Constants.Spacing.s){
            Text(title)
                .font(Constants.Fonts.title)
                .foregroundStyle(Constants.Colors.pink)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(Constants.Fonts.headline)
                .foregroundStyle(.white.opacity(0.6))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    EmptyStateView(title: "Title", subtitle: "Subtitle")
}
