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
                                .font(Constants.Fonts.title)
                                .foregroundStyle(Constants.Colors.pink)
                                .background(
                                    Circle()
                                        .fill(.white)
                                        .frame(height: 10)
                                )
                        }
                    }
                    .overlay(
                        Circle()
                            .stroke(Constants.Colors.pink, lineWidth: 1)
                    )
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
                    .overlay(
                        Circle()
                            .stroke(Constants.Colors.pink, lineWidth: 1)
                    )
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

#Preview {
    VStack {
        PhotoPickerButtonPreview()
        PhotoPickerButtonPreview(hasImage: true)
    }
}

private struct PhotoPickerButtonPreview: View {
    @State private var selectedImage: UIImage?
    let hasImage: Bool
    
    init(hasImage: Bool = false) {
        self.hasImage = hasImage
        if hasImage {
            _selectedImage = State(initialValue: .logoicon)
        }
    }
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .ignoresSafeArea()
            
            PhotoPickerButton(selectedImage: $selectedImage)
        }
    }
}
