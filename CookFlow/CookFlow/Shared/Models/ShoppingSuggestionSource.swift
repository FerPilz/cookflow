//
//  ShoppingSuggestionSource.swift
//  CookFlow
//
//  Created by Codex on 3/25/26.
//

import Foundation

struct ShoppingItemSuggestion: Identifiable, Hashable {
    let name: String
    let normalizedName: String
    let unit: String?
    let category: String?
    let isCommonGrocery: Bool

    var id: String {
        "\(normalizedName)|\(unit ?? "")"
    }
}

struct ShoppingSuggestionSource {
    private let suggestions: [ShoppingItemSuggestion]

    init(
        recipeSuggestions: [ShoppingItemSuggestion] = ShoppingIngredientParser.ingredientSuggestions(from: SampleData.allRecipes),
        commonGroceries: [ShoppingItemSuggestion] = ShoppingSuggestionSource.commonGroceries
    ) {
        var seen = Set<String>()
        self.suggestions = (recipeSuggestions + commonGroceries).filter { suggestion in
            guard !seen.contains(suggestion.id) else { return false }
            seen.insert(suggestion.id)
            return true
        }
    }

    func matches(for query: String, limit: Int = 6) -> [ShoppingItemSuggestion] {
        let normalizedQuery = ShoppingItem.normalize(query)
        guard !normalizedQuery.isEmpty else { return [] }

        return suggestions
            .filter { suggestion in
                suggestion.normalizedName.contains(normalizedQuery)
            }
            .sorted { lhs, rhs in
                score(for: lhs, query: normalizedQuery) < score(for: rhs, query: normalizedQuery)
            }
            .prefix(limit)
            .map { $0 }
    }

    private func score(for suggestion: ShoppingItemSuggestion, query: String) -> Int {
        if suggestion.normalizedName == query {
            return 0
        }

        if suggestion.normalizedName.hasPrefix(query) {
            return suggestion.isCommonGrocery ? 2 : 1
        }

        if suggestion.normalizedName.contains(query) {
            return suggestion.isCommonGrocery ? 4 : 3
        }

        return 5
    }

    private static let commonGroceries: [ShoppingItemSuggestion] = [
        .init(name: "Bananas", normalizedName: ShoppingItem.normalize("Bananas"), unit: "pcs", category: "Produce", isCommonGrocery: true),
        .init(name: "Apples", normalizedName: ShoppingItem.normalize("Apples"), unit: "pcs", category: "Produce", isCommonGrocery: true),
        .init(name: "Spinach", normalizedName: ShoppingItem.normalize("Spinach"), unit: "pack", category: "Produce", isCommonGrocery: true),
        .init(name: "Greek yogurt", normalizedName: ShoppingItem.normalize("Greek yogurt"), unit: "cup", category: "Dairy", isCommonGrocery: true),
        .init(name: "Eggs", normalizedName: ShoppingItem.normalize("Eggs"), unit: "pcs", category: "Protein", isCommonGrocery: true),
        .init(name: "Chicken breast", normalizedName: ShoppingItem.normalize("Chicken breast"), unit: "lb", category: "Protein", isCommonGrocery: true),
        .init(name: "Ground beef", normalizedName: ShoppingItem.normalize("Ground beef"), unit: "lb", category: "Protein", isCommonGrocery: true),
        .init(name: "Olive oil", normalizedName: ShoppingItem.normalize("Olive oil"), unit: "tbsp", category: "Pantry", isCommonGrocery: true),
        .init(name: "Brown rice", normalizedName: ShoppingItem.normalize("Brown rice"), unit: "cup", category: "Pantry", isCommonGrocery: true),
        .init(name: "Pasta", normalizedName: ShoppingItem.normalize("Pasta"), unit: "lb", category: "Pantry", isCommonGrocery: true),
        .init(name: "Sparkling water", normalizedName: ShoppingItem.normalize("Sparkling water"), unit: "can", category: "Drinks", isCommonGrocery: true),
        .init(name: "Frozen berries", normalizedName: ShoppingItem.normalize("Frozen berries"), unit: "pack", category: "Frozen", isCommonGrocery: true)
    ]
}
