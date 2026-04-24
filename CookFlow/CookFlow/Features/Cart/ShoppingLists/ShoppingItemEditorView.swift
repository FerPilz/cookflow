import SwiftUI
import UIKit

struct ShoppingItemEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager

    let title: String
    let initialItem: ShoppingItem?
    let onSave: (ShoppingItem) -> Void
    private let suggestionSource: ShoppingSuggestionSource

    @State private var name: String
    @State private var quantityText: String
    @State private var unit: String
    @State private var category: String

    init(
        title: String,
        initialItem: ShoppingItem? = nil,
        suggestionSource: ShoppingSuggestionSource = ShoppingSuggestionSource(),
        onSave: @escaping (ShoppingItem) -> Void
    ) {
        self.title = title
        self.initialItem = initialItem
        self.suggestionSource = suggestionSource
        self.onSave = onSave
        _name = State(initialValue: initialItem?.name ?? "")
        _quantityText = State(initialValue: {
            guard let quantity = initialItem?.quantity else { return "" }
            if quantity.rounded() == quantity {
                return String(Int(quantity))
            }
            return String(format: "%.1f", quantity)
        }())
        _unit = State(initialValue: initialItem?.unit ?? "")
        _category = State(initialValue: initialItem?.category ?? "Other")
    }

    var body: some View {
        let colors = themeManager.palette

        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                    Text(title)
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(colors.primaryText)

                    editorField(label: "Item", placeholder: "Olive oil", text: $name, keyboardType: .default)

                    if !suggestions.isEmpty {
                        suggestionList
                    }

                    HStack(alignment: .top, spacing: DesignSystem.Spacing.md) {
                        fieldCard(label: "Quantity", text: $quantityText, keyboardType: .decimalPad)
                        fieldCard(label: "Unit", text: $unit, keyboardType: .default)
                    }

                    fieldCard(label: "Category", text: $category, keyboardType: .default)

                    PrimaryButton(title: "Save Item", isEnabled: isSaveEnabled) {
                        save()
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, DesignSystem.Spacing.lg)
            }
            .background(colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(colors.primaryText)
                }
            }
        }
    }

    private var suggestions: [ShoppingItemSuggestion] {
        let matches = suggestionSource.matches(for: name)
        let normalizedName = ShoppingItem.normalize(name)
        return matches.filter { $0.normalizedName != normalizedName }
    }

    private var suggestionList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(suggestions) { suggestion in
                Button(action: { applySuggestion(suggestion) }) {
                    HStack {
                        Text(suggestion.name)
                            .font(DesignSystem.Fonts.subtitle)
                            .foregroundColor(themeManager.palette.primaryText)

                        Spacer()
                    }
                    .padding(.horizontal, DesignSystem.Spacing.md)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.plain)

                if suggestion.id != suggestions.last?.id {
                    Divider()
                        .overlay(DesignSystem.Colors.divider)
                }
            }
        }
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private func editorField(label: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text(label)
                .font(DesignSystem.Fonts.stepLabel)
                .foregroundColor(DesignSystem.Colors.textMuted)

            TextField(
                "",
                text: text,
                prompt: Text(placeholder)
                    .foregroundColor(DesignSystem.Colors.textMuted.opacity(0.9))
            )
            .font(DesignSystem.Fonts.body)
            .foregroundColor(DesignSystem.Colors.primaryText)
            .keyboardType(keyboardType)
            .tint(DesignSystem.Colors.accent)
            .padding(DesignSystem.Spacing.md)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func fieldCard(label: String, text: Binding<String>, keyboardType: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text(label)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)

            TextField(
                "",
                text: text,
                prompt: Text(label)
                    .foregroundColor(DesignSystem.Colors.textMuted.opacity(0.9))
            )
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .keyboardType(keyboardType)
                .tint(DesignSystem.Colors.accent)
                .padding(.horizontal, DesignSystem.Spacing.md)
                .padding(.vertical, 14)
                .background(DesignSystem.Colors.card)
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                        .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var isSaveEnabled: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func save() {
        let quantity = ShoppingItem.parseQuantity(quantityText)
        let item = ShoppingItem(
            id: initialItem?.id ?? UUID(),
            name: name,
            quantity: quantity,
            unit: unit.isEmpty ? nil : unit,
            isChecked: initialItem?.isChecked ?? false,
            sourceRecipes: initialItem?.sourceRecipes ?? [],
            category: category.isEmpty ? nil : category,
            isManualItem: initialItem?.isManualItem ?? true
        )
        onSave(item)
        dismiss()
    }

    private func applySuggestion(_ suggestion: ShoppingItemSuggestion) {
        name = suggestion.name
        if unit.isEmpty, let suggestionUnit = suggestion.unit {
            unit = suggestionUnit
        }
        if category.isEmpty || category == "Other", let suggestionCategory = suggestion.category {
            category = suggestionCategory
        }
    }
}

#Preview {
    ShoppingItemEditorView(title: "Edit Item", initialItem: ShoppingItem(name: "Lemons", quantity: 3, unit: "pcs", category: "Produce", isManualItem: true)) { _ in }
        .environmentObject(ThemeManager(theme: .light))
        .preferredColorScheme(.light)
}
