import SwiftUI

struct LoadingView: View {
    @State private var loading: CGFloat = 0
    
    var body: some View {
        ZStack {
            Image(.lodingbg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(.logoicon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Image(.lodingtitle)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Spacer()
                
                Capsule()
                    .foregroundStyle(Constants.Colors.background)
                    .frame(maxWidth: 250, maxHeight: 17)
                    .overlay(alignment: .leading) {
                        Capsule()
                            .foregroundStyle(Constants.Colors.pink)
                            .frame(width: 248 * loading, height: 15)
                            .padding(.horizontal, 1)
                    }
                    .overlay {
                        Capsule()
                            .stroke(.white, lineWidth: 1.5)
                    }
                    .overlay {
                        Text("Loading...")
                            .font(Constants.Fonts.caption)
                            .foregroundStyle(.white)
                    }
            }
            .padding(.bottom)
        }
        .onAppear {
            withAnimation(.linear(duration: 3)) {
                loading = 1
            }
        }
    }
}

#Preview {
    LoadingView()
}
