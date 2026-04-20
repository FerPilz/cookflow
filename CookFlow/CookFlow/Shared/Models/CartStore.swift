//
//  CartStore.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import Foundation
import Combine

struct CartIngredient: Hashable {
    let name: String
    let quantity: Double?
    let unit: String?
    let category: String?
}

@MainActor
final class CartStore: ObservableObject {
    @Published private(set) var items: [ShoppingItem] = []

    var groupedItems: [ShoppingItemGroup] {
        var orderedTitles: [String] = []
        var grouped: [String: [ShoppingItem]] = [:]

        for item in items {
            let title = item.resolvedCategory
            if grouped[title] == nil {
                orderedTitles.append(title)
                grouped[title] = []
            }
            grouped[title]?.append(item)
        }

        return orderedTitles.map { title in
            ShoppingItemGroup(
                title: title,
                items: grouped[title] ?? []
            )
        }
    }

    func add(_ ingredient: CartIngredient, for recipe: Recipe) {
        add(ingredient: ingredient, for: recipe)
    }

    func add(ingredient: CartIngredient, for recipe: Recipe) {
        let trimmedName = ingredient.name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let candidate = ShoppingItem(
            name: trimmedName,
            quantity: ingredient.quantity,
            unit: ShoppingIngredientParser.normalizedUnit(ingredient.unit),
            isChecked: false,
            sourceRecipes: [ShoppingItemSource(recipeID: recipe.id, recipeTitle: recipe.title)],
            category: ingredient.category,
            isManualItem: false
        )

        if let existingIndex = items.firstIndex(where: {
            !$0.isManualItem && $0.normalizedName == candidate.normalizedName && $0.unit == candidate.unit
        }), let merged = items[existingIndex].merged(with: candidate) {
            items[existingIndex] = merged
            items[existingIndex].isChecked = false
            return
        }

        items.append(candidate)
    }

    func addManualItem(name: String, quantity: Double? = nil, unit: String? = nil, category: String? = nil) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        items.insert(
            ShoppingItem(
                name: trimmedName,
                quantity: quantity,
                unit: ShoppingIngredientParser.normalizedUnit(unit),
                isChecked: false,
                sourceRecipes: [],
                category: category,
                isManualItem: true
            ),
            at: 0
        )
    }

    func addAll(_ ingredients: [CartIngredient], for recipe: Recipe) {
        ingredients.forEach { add(ingredient: $0, for: recipe) }
    }

    func remove(itemID: UUID) {
        items.removeAll { $0.id == itemID }
    }

    func clearCategory(_ title: String) {
        items.removeAll { $0.resolvedCategory == title }
    }

    func clearAll() {
        items.removeAll()
    }

    func toggleChecked(itemID: UUID) {
        guard let index = items.firstIndex(where: { $0.id == itemID }) else { return }
        items[index].isChecked.toggle()
    }

    func updateItem(_ item: ShoppingItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index] = item
    }

    func incrementQuantity(itemID: UUID) {
        guard let index = items.firstIndex(where: { $0.id == itemID }) else { return }
        let current = items[index].quantity ?? 0
        items[index].quantity = current + 1
    }

    func decrementQuantity(itemID: UUID) {
        guard let index = items.firstIndex(where: { $0.id == itemID }) else { return }
        guard let current = items[index].quantity, current > 1 else {
            items[index].quantity = nil
            return
        }
        items[index].quantity = current - 1
    }
}
