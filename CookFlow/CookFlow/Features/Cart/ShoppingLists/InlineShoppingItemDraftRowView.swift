import SwiftUI

struct InlineShoppingItemDraftRowView: View {
    @Binding var name: String
    @Binding var quantityText: String
    let suggestions: [ShoppingItemSuggestion]
    let onSelectSuggestion: (ShoppingItemSuggestion) -> Void
    let onSubmit: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack(alignment: .center, spacing: DesignSystem.Spacing.sm) {
                field(text: $name, placeholder: "Item", keyboardType: .default)
                    .frame(maxWidth: .infinity)

                field(text: $quantityText, placeholder: "Qty", keyboardType: .decimalPad)
                    .frame(width: 78)

                Button(action: onSubmit) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.onAccentText)
                        .frame(width: 32, height: 32)
                        .background(DesignSystem.Colors.ctaGreen)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.45 : 1)

                Button(action: onCancel) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                        .frame(width: 32, height: 32)
                        .background(DesignSystem.Colors.secondaryBackground)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }

            if !suggestions.isEmpty {
                suggestionList
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.md)
        .padding(.vertical, 10)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private func field(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType) -> some View {
        TextField(
            "",
            text: text,
            prompt: Text(placeholder)
                .foregroundColor(DesignSystem.Colors.secondaryText.opacity(0.8))
        )
        .font(DesignSystem.Fonts.subtitle)
        .foregroundColor(DesignSystem.Colors.primaryText)
        .tint(DesignSystem.Colors.accent)
        .keyboardType(keyboardType)
        .textInputAutocapitalization(.words)
        .disableAutocorrection(true)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(DesignSystem.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private var suggestionList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(suggestions) { suggestion in
                Button(action: { onSelectSuggestion(suggestion) }) {
                    HStack {
                        Text(suggestion.name)
                            .font(DesignSystem.Fonts.subtitle)
                            .foregroundColor(DesignSystem.Colors.textCream)
                            .lineLimit(1)

                        Spacer()
                    }
                    .padding(.horizontal, DesignSystem.Spacing.md)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)

                if suggestion.id != suggestions.last?.id {
                    Divider()
                        .overlay(DesignSystem.Colors.divider)
                }
            }
        }
        .background(DesignSystem.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    InlineShoppingItemDraftRowView(
        name: .constant("Milk"),
        quantityText: .constant("2"),
        suggestions: [
            ShoppingItemSuggestion(name: "Milk", normalizedName: "milk", unit: nil, category: "Dairy", isCommonGrocery: true)
        ],
        onSelectSuggestion: { _ in },
        onSubmit: {},
        onCancel: {}
    )
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
