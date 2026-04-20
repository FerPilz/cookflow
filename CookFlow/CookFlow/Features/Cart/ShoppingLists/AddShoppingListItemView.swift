import SwiftUI

struct AddShoppingListItemView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var shoppingListStore: ShoppingListStore

    let listID: UUID

    @State private var ingredientName = ""
    @State private var quantity = "1"
    @State private var shoppingCategory = "Other"

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                    Text("Add Item")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    InputField(label: "Ingredient", placeholder: "Ingredient", text: $ingredientName)

                    InputField(label: "Quantity", placeholder: "1", text: $quantity)

                    VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                        Text("Category")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)

                        Picker("Category", selection: $shoppingCategory) {
                            ForEach(categoryOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(DesignSystem.Colors.textCream)
                    }

                    PrimaryButton(title: "Add Item", isEnabled: isSaveEnabled) {
                        addItem()
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, DesignSystem.Spacing.lg)
            }
            .background(DesignSystem.Colors.backgroundNearBlack)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(DesignSystem.Colors.textCream)
                }
            }
        }
    }

    private var isSaveEnabled: Bool {
        !ingredientName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func addItem() {
        let trimmedName = ingredientName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let item = ShoppingListItem(
            name: trimmedName,
            quantity: ShoppingItem.parseQuantity(quantity),
            unit: nil,
            isChecked: false,
            sourceRecipes: [],
            category: shoppingCategory,
            isManualItem: true
        )
        shoppingListStore.addItem(to: listID, item: item)

        ingredientName = ""
        quantity = "1"
        shoppingCategory = "Other"
    }

    private var categoryOptions: [String] {
        ["Produce", "Protein", "Dairy", "Pantry", "Bakery", "Frozen", "Drinks", "Other"]
    }
}

#Preview {
    AddShoppingListItemView(listID: UUID())
        .environmentObject(ShoppingListStore())
        .preferredColorScheme(.dark)
}
