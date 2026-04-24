//
//  GroceryListView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var cart: CartStore
    @EnvironmentObject private var shoppingListStore: ShoppingListStore
    @EnvironmentObject private var themeManager: ThemeManager
    private let suggestionSource = ShoppingSuggestionSource()
    @State private var isShoppingListsPresented = false
    @State private var isAddingInlineItem = false
    @State private var draftItemName = ""
    @State private var draftQuantityText = ""

    var body: some View {
        let colors = themeManager.palette

        NavigationStack {
            VStack(spacing: 0) {
                if cart.items.isEmpty {
                    emptyState
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                            ForEach(cart.groupedItems) { group in
                                categorySection(group)
                            }
                        }
                        .padding(.horizontal, DesignSystem.Spacing.lg)
                        .padding(.bottom, DesignSystem.Spacing.lg)
                    }
                }
            }
            .background(colors.background)
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(colors.primaryText)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Back")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: DesignSystem.Spacing.xs) {
                        if !cart.items.isEmpty {
                            Button("Clear all") {
                                cart.clearAll()
                            }
                            .foregroundColor(colors.secondaryText)
                        }

                        Button(action: openShoppingListAction) {
                            Image(systemName: "list.bullet.rectangle")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(colors.primaryText)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Shopping lists")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                footerBar
                    .background(colors.background)
            }
        }
        .navigationDestination(isPresented: $isShoppingListsPresented) {
            ShoppingListsView()
        }
    }

    private func categorySection(_ group: ShoppingItemGroup) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack {
                Text(group.title)
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                Spacer()

                Button("Clear") {
                    cart.clearCategory(group.title)
                }
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
            }

            VStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(group.items) { item in
                    ShoppingItemRowView(
                        item: item,
                        onToggleChecked: { cart.toggleChecked(itemID: item.id) },
                        onIncrement: { cart.incrementQuantity(itemID: item.id) },
                        onDecrement: { cart.decrementQuantity(itemID: item.id) }
                    )
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            cart.remove(itemID: item.id)
                        } label: {
                            Text("Delete")
                        }
                    }
                }
            }
        }
    }

    private var footerBar: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
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

            HStack(spacing: DesignSystem.Spacing.sm) {
                Button(action: beginInlineItem) {
                    Text("+ Item")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.ctaGreen)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(DesignSystem.Colors.card)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)

                Button(action: openShoppingListAction) {
                    Text("+ Shopping List")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.onAccentText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(DesignSystem.Colors.ctaGreen)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.top, DesignSystem.Spacing.sm)
        .padding(.bottom, DesignSystem.Spacing.lg)
    }

    private var emptyState: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Image(systemName: "cart")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textTertiary)

            Text("Your cart is empty")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)
        }
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

        cart.addManualItem(
            name: trimmedName,
            quantity: ShoppingItem.parseQuantity(draftQuantityText),
            category: category
        )
        cancelInlineItem()
    }

    private func openShoppingListAction() {
        isShoppingListsPresented = true
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

#Preview("Light Mode") {
    CartView()
        .environmentObject(CartStore())
        .environmentObject(ShoppingListStore())
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}
