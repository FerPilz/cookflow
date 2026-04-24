import SwiftUI

struct DSTextField: View {
    let placeholder: String
    @Binding var text: String

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .fill(DesignSystem.Colors.card.opacity(0.95))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                        .stroke(borderColor, lineWidth: 1.5)
                )

            if text.isEmpty {
                Text(placeholder)
                    .font(DesignSystem.Fonts.link)
                    .foregroundColor(DesignSystem.Colors.textMuted.opacity(0.8))
                    .lineLimit(1)
                    .padding(.horizontal, DesignSystem.Spacing.md)
            }

            TextField("", text: $text)
                .font(DesignSystem.Fonts.link)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .lineLimit(1)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .tint(DesignSystem.Colors.accent)
                .focused($isFocused)
                .padding(.horizontal, DesignSystem.Spacing.md)
        }
        .frame(height: 56)
    }

    private var borderColor: Color {
        isFocused ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.divider
    }
}

#Preview {
    DSTextField(placeholder: "Continue with Email", text: .constant(""))
        .padding()
        .background(DesignSystem.Colors.background)
        .preferredColorScheme(.light)
}
