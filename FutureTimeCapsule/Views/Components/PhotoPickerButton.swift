import SwiftUI
import PhotosUI

struct PhotoPickerButton: View {
    @Binding var selectedImage: UIImage?
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        ZStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.Components.photoFrameSize, height: Constants.Components.photoFrameSize)
                    .clipShape(Circle())
                    .overlay(alignment: .topTrailing) {
                        Button {
                            selectedImage = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .background(
                                    Circle()
                                        .fill(Constants.Colors.pink)
                                        .frame(width: 28, height: 28)
                                )
                        }
                        .offset(x: 10, y: -10)
                    }
            } else {
                PhotosPicker(selection: $photoItem, matching: .images) {
                    VStack(spacing: Constants.Spacing.s) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Constants.Colors.yellow)
                        
                        Text("Take a Photo")
                            .font(Constants.Fonts.body)
                            .foregroundStyle(.white)
                    }
                    .frame(width: Constants.Components.photoFrameSize, height: Constants.Components.photoFrameSize)
                    .background(Constants.Colors.blue)
                    .clipShape(Circle())
                }
            }
        }
        .onChange(of: photoItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImage = image
                }
            }
        }
    }
}
