//
//  ShoppingIngredientParser.swift
//  CookFlow
//
//  Created by Codex on 3/25/26.
//

import Foundation

enum ShoppingIngredientParser {
    static func cartIngredients(from recipe: Recipe) -> [CartIngredient] {
        recipe.ingredients
            .map(parseIngredientLine)
            .filter { !$0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    static func ingredientSuggestions(from recipes: [Recipe]) -> [ShoppingItemSuggestion] {
        var seen = Set<String>()

        return recipes
            .flatMap(\.ingredients)
            .compactMap { line in
                let ingredient = parseIngredientLine(line)
                let key = "\(ShoppingItem.normalize(ingredient.name))|\(ingredient.unit?.lowercased() ?? "")"
                guard !ingredient.name.isEmpty, !seen.contains(key) else { return nil }
                seen.insert(key)
                return ShoppingItemSuggestion(
                    name: ingredient.name,
                    normalizedName: ShoppingItem.normalize(ingredient.name),
                    unit: ingredient.unit,
                    category: ingredient.category,
                    isCommonGrocery: false
                )
            }
    }

    static func parseIngredientLine(_ line: String) -> CartIngredient {
        let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return CartIngredient(name: "", quantity: nil, unit: nil, category: nil)
        }

        let tokens = trimmed.split(separator: " ").map(String.init)
        guard let first = tokens.first,
              first.rangeOfCharacter(from: .decimalDigits) != nil else {
            return CartIngredient(
                name: trimmed,
                quantity: nil,
                unit: nil,
                category: inferredCategory(for: trimmed)
            )
        }

        let quantity = ShoppingItem.parseQuantity(first)
        let remainder = Array(tokens.dropFirst())

        if remainder.count >= 2 {
            let unit = remainder[0]
            let name = remainder.dropFirst().joined(separator: " ")
            return CartIngredient(
                name: name,
                quantity: quantity,
                unit: normalizedUnit(unit),
                category: inferredCategory(for: name)
            )
        }

        if let onlyToken = remainder.first {
            return CartIngredient(
                name: onlyToken,
                quantity: quantity,
                unit: nil,
                category: inferredCategory(for: onlyToken)
            )
        }

        return CartIngredient(name: trimmed, quantity: nil, unit: nil, category: inferredCategory(for: trimmed))
    }

    static func inferredCategory(for ingredientName: String) -> String {
        let normalized = ingredientName.lowercased()

        if normalized.contains("milk") || normalized.contains("yogurt") || normalized.contains("cheese") || normalized.contains("butter") {
            return "Dairy"
        }

        if normalized.contains("chicken") || normalized.contains("beef") || normalized.contains("salmon") || normalized.contains("egg") {
            return "Protein"
        }

        if normalized.contains("bread") || normalized.contains("bagel") || normalized.contains("bun") {
            return "Bakery"
        }

        if normalized.contains("juice") || normalized.contains("soda") || normalized.contains("water") || normalized.contains("coffee") {
            return "Drinks"
        }

        if normalized.contains("frozen") {
            return "Frozen"
        }

        if normalized.contains("salt")
            || normalized.contains("pepper")
            || normalized.contains("oil")
            || normalized.contains("rice")
            || normalized.contains("beans")
            || normalized.contains("pasta")
            || normalized.contains("flour") {
            return "Pantry"
        }

        return "Produce"
    }

    static func normalizedUnit(_ unit: String?) -> String? {
        guard let unit else { return nil }
        let cleaned = unit.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        switch cleaned {
        case "tbsp", "tablespoon", "tablespoons":
            return "tbsp"
        case "tsp", "teaspoon", "teaspoons":
            return "tsp"
        case "cup", "cups":
            return "cup"
        case "lb", "lbs", "pound", "pounds":
            return "lb"
        case "oz", "ounce", "ounces":
            return "oz"
        case "g", "gram", "grams":
            return "g"
        case "kg", "kilogram", "kilograms":
            return "kg"
        case "ml":
            return "ml"
        case "l", "liter", "liters":
            return "l"
        case "clove", "cloves":
            return "clove"
        case "can", "cans":
            return "can"
        case "pack", "packs":
            return "pack"
        case "pcs", "piece", "pieces":
            return "pcs"
        default:
            return cleaned.isEmpty ? nil : cleaned
        }
    }
}
