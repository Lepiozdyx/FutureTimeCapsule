import SwiftUI

struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    let maxCharacters: Int
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(Constants.Fonts.body)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.horizontal, Constants.Spacing.m)
                    .padding(.top, Constants.Spacing.s + 8)
            }
            
            TextEditor(text: $text)
                .font(Constants.Fonts.body)
                .foregroundStyle(.white)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, Constants.Spacing.s)
                .padding(.vertical, Constants.Spacing.s)
                .onChange(of: text) { oldValue, newValue in
                    if newValue.count > maxCharacters {
                        text = String(newValue.prefix(maxCharacters))
                    }
                }
        }
        .frame(height: Constants.Components.textEditorSize)
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                .fill(Color(hex: "2A1F3D"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                .stroke(Constants.Colors.pink, lineWidth: 1.5)
        )
        .overlay(alignment: .bottomTrailing) {
            Text("Max \(maxCharacters) chars")
                .font(Constants.Fonts.caption)
                .foregroundStyle(.white.opacity(0.6))
                .padding(Constants.Spacing.s)
        }
    }
}
