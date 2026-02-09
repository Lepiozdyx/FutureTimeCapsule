import SwiftUI

struct CreateCapsuleView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var storageManager = StorageManager.shared
    
    @State private var selectedImage: UIImage?
    @State private var title = ""
    @State private var message = ""
    @State private var selectedDreamType: DreamType?
    @State private var selectedAboutType: AboutType = .myself
    @State private var openDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }
    
    private var maxDate: Date {
        let components = DateComponents(year: 2040, month: 12, day: 31)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private var canSeal: Bool {
        !title.isEmpty && !message.isEmpty && selectedDreamType != nil
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.Spacing.m) {
                    PhotoPickerButton(selectedImage: $selectedImage)
                        .padding(.top, Constants.Spacing.l)
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                        Text("Title:")
                            .font(Constants.Fonts.headline)
                            .foregroundStyle(.white)
                        
                        CustomTextField(placeholder: "Enter a name", text: $title)
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                        Text("Message:")
                            .font(Constants.Fonts.headline)
                            .foregroundStyle(.white)
                        
                        CustomTextEditor(
                            placeholder: "What do you want to say to yourself in 2030?",
                            text: $message,
                            maxCharacters: 300
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                        Text("Dream type:")
                            .font(Constants.Fonts.headline)
                            .foregroundStyle(.white)
                        
                        HStack(spacing: Constants.Spacing.m) {
                            ForEach(DreamType.allCases, id: \.self) { type in
                                DreamTypeButton(
                                    dreamType: type,
                                    isSelected: selectedDreamType == type
                                ) {
                                    selectedDreamType = type
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                        Text("About:")
                            .font(Constants.Fonts.headline)
                            .foregroundStyle(.white)
                        
                        Menu {
                            ForEach(AboutType.allCases, id: \.self) { type in
                                Button(type.displayName) {
                                    selectedAboutType = type
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedAboutType.displayName)
                                    .font(Constants.Fonts.body)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .font(Constants.Fonts.headline)
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, Constants.Spacing.m)
                            .frame(height: Constants.Components.textFieldSize)
                            .background(
                                RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                    .fill(Constants.Colors.card)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                    .stroke(Constants.Colors.pink, lineWidth: 1)
                            )
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.s) {
                        Text("Open Date:")
                            .font(Constants.Fonts.headline)
                            .foregroundStyle(.white)
                        
                        DatePicker(
                            "Select a date",
                            selection: $openDate,
                            in: tomorrow...maxDate,
                            displayedComponents: .date                        )
                        .datePickerStyle(.compact)
//                        .labelsHidden()
                        .tint(Constants.Colors.pink)
                        .padding(.horizontal, Constants.Spacing.m)
                        .frame(height: Constants.Components.textFieldSize)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                .fill(Constants.Colors.card)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                .stroke(Constants.Colors.pink, lineWidth: 1)
                        )
                    }
                    
                    CustomButton(title: "Seal the Capsule") {
                        sealCapsule()
                    }
                    .padding(.top, Constants.Spacing.m)
                    .opacity(canSeal ? 1 : 0.5)
                    .disabled(!canSeal)
                }
                .padding(.horizontal, Constants.Spacing.m)
                .padding(.bottom, Constants.Spacing.xl)
            }
            .contentMargins(.bottom, 60, for: .scrollContent)
            .scrollIndicators(.hidden)
            .background(Constants.Colors.background.ignoresSafeArea())
            .navigationTitle("Create Time Capsule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Constants.Colors.pink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    private func sealCapsule() {
        guard canSeal, let dreamType = selectedDreamType else {
            alertMessage = "Please fill in all required fields"
            showAlert = true
            return
        }
        
        let imageData = compressImage(selectedImage)
        
        let capsule = FutureCapsule(
            title: title,
            message: message,
            imageData: imageData,
            dreamType: dreamType,
            aboutType: selectedAboutType,
            openDate: openDate
        )
        
        storageManager.addCapsule(capsule)
        NotificationManager.shared.scheduleNotification(for: capsule)
        
        dismiss()
    }
    
    private func compressImage(_ image: UIImage?) -> Data? {
        guard let image = image else { return nil }
        
        let maxSize: CGFloat = 500
        var newImage = image
        
        if image.size.width > maxSize || image.size.height > maxSize {
            let ratio = image.size.width / image.size.height
            let newSize: CGSize
            
            if ratio > 1 {
                newSize = CGSize(width: maxSize, height: maxSize / ratio)
            } else {
                newSize = CGSize(width: maxSize * ratio, height: maxSize)
            }
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: CGRect(origin: .zero, size: newSize))
            newImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
            UIGraphicsEndImageContext()
        }
        
        return newImage.jpegData(compressionQuality: 0.5)
    }
}

#Preview {
    CreateCapsuleView()
}
