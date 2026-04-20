import SwiftUI

struct ShoppingListDetailView: View {
    @EnvironmentObject private var shoppingListStore: ShoppingListStore
    private let suggestionSource = ShoppingSuggestionSource()
    @State private var isAddingInlineItem = false
    @State private var draftItemName = ""
    @State private var draftQuantityText = ""

    let listID: UUID

    var body: some View {
        Group {
            if let list = shoppingListStore.list(for: listID) {
                VStack(spacing: 0) {
                    listHeader(list)
                        .padding(.horizontal, DesignSystem.Spacing.lg)
                        .padding(.top, DesignSystem.Spacing.md)
                        .padding(.bottom, DesignSystem.Spacing.md)

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                            if isAddingInlineItem {
                                InlineShoppingItemDraftRowView(
                                    name: $draftItemName,
                                    quantityText: $draftQuantityText,
                                    suggestions: liveSuggestions,
                                    onSelectSuggestion: applySuggestion,
                                    onSubmit: addInlineItem,
                                    onCancel: cancelInlineItem
                                )
                            }

                            ForEach(list.groupedItems) { group in
                                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                                    Text(group.title)
                                        .font(DesignSystem.Fonts.subtitle)
                                        .foregroundColor(DesignSystem.Colors.textCream)

                                    VStack(spacing: DesignSystem.Spacing.sm) {
                                        ForEach(group.items) { item in
                                            ShoppingItemRowView(
                                                item: item,
                                                onToggleChecked: { shoppingListStore.toggleItem(listID: listID, itemID: item.id) },
                                                onIncrement: { shoppingListStore.incrementItem(listID: listID, itemID: item.id) },
                                                onDecrement: { shoppingListStore.decrementItem(listID: listID, itemID: item.id) }
                                            )
                                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                Button(role: .destructive) {
                                                    shoppingListStore.removeItem(listID: listID, itemID: item.id)
                                                } label: {
                                                    Text("Delete")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, DesignSystem.Spacing.lg)
                        .padding(.bottom, DesignSystem.Spacing.lg)
                    }
                }
                .background(DesignSystem.Colors.backgroundNearBlack)
                .navigationTitle(list.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: beginInlineItem) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                                .frame(width: 44, height: 44)
                                .background(DesignSystem.Colors.ctaGreen)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Add item")
                    }
                }
            } else {
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textTertiary)

                    Text("List not found")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(DesignSystem.Colors.backgroundNearBlack)
            }
        }
        .tint(DesignSystem.Colors.textCream)
    }

    private func listHeader(_ list: ShoppingList) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text("Saved list")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.ctaGreen)

            Text("\(list.items.count) items organized by category for quicker checking and cleanup.")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DesignSystem.Spacing.lg)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private func beginInlineItem() {
        isAddingInlineItem = true
    }

    private func cancelInlineItem() {
        draftItemName = ""
        draftQuantityText = ""
        isAddingInlineItem = false
    }

    private func addInlineItem() {
        let trimmedName = draftItemName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let normalizedName = ShoppingItem.normalize(trimmedName)
        let category = suggestionSource.matches(for: trimmedName).first(where: { $0.normalizedName == normalizedName })?.category
            ?? suggestionSource.matches(for: trimmedName).first?.category
            ?? "Other"

        let item = ShoppingListItem(
            name: trimmedName,
            quantity: ShoppingItem.parseQuantity(draftQuantityText),
            unit: nil,
            isChecked: false,
            sourceRecipes: [],
            category: category,
            isManualItem: true
        )
        shoppingListStore.addItem(to: listID, item: item)
        cancelInlineItem()
    }

    private var liveSuggestions: [ShoppingItemSuggestion] {
        let trimmedName = draftItemName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return [] }

        let normalizedName = ShoppingItem.normalize(trimmedName)
        return suggestionSource.matches(for: trimmedName).filter { $0.normalizedName != normalizedName }
    }

    private func applySuggestion(_ suggestion: ShoppingItemSuggestion) {
        draftItemName = suggestion.name
    }
}

#Preview {
    NavigationStack {
        ShoppingListDetailView(listID: UUID())
            .environmentObject(ShoppingListStore())
            .preferredColorScheme(.dark)
    }
}
