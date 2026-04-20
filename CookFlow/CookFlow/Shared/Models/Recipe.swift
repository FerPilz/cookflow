//
//  Recipe.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var id: String
    var title: String
    var category: String
    var summaryText: String
    var heroImageName: String
    var calories: Int?
    var prepMinutes: Int?
    var cookMinutes: Int?
    var quantityText: String
    var ingredientsText: String
    var instructionsText: String
    var sourceURLString: String?
    var createdAt: Date

    init(
        id: String = UUID().uuidString,
        title: String,
        category: String,
        summaryText: String = "",
        heroImageName: String = "",
        calories: Int? = nil,
        prepMinutes: Int? = nil,
        cookMinutes: Int? = nil,
        quantityText: String = "Serves 2",
        ingredientsText: String,
        instructionsText: String,
        sourceURLString: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.summaryText = summaryText
        self.heroImageName = heroImageName
        self.calories = calories
        self.prepMinutes = prepMinutes
        self.cookMinutes = cookMinutes
        self.quantityText = quantityText
        self.ingredientsText = ingredientsText
        self.instructionsText = instructionsText
        self.sourceURLString = sourceURLString
        self.createdAt = createdAt
    }

    convenience init(
        title: String,
        subtitle: String,
        category: String? = nil,
        imageURL: URL? = nil,
        tag: String? = nil,
        durationMinutes: Int? = nil,
        calories: Int? = nil,
        likes: Int? = nil,
        amountText: String? = nil
    ) {
        let resolvedCategory = category ?? "Other"
        self.init(
            title: title,
            category: resolvedCategory,
            summaryText: subtitle,
            heroImageName: "",
            calories: calories,
            prepMinutes: durationMinutes,
            cookMinutes: nil,
            quantityText: amountText ?? "Serves 2",
            ingredientsText: "Olive oil\nSalt\nBlack pepper",
            instructionsText: "Prep ingredients.\nCook until done.\nPlate and serve.",
            sourceURLString: imageURL?.absoluteString,
            createdAt: Date()
        )
    }

    var imageName: String? {
        get { heroImageName.isEmpty ? nil : heroImageName }
        set { heroImageName = newValue ?? "" }
    }

    var subtitle: String {
        summaryText.isEmpty ? category : summaryText
    }

    var durationMinutes: Int? {
        if let prepMinutes, let cookMinutes {
            return prepMinutes + cookMinutes
        }
        return prepMinutes ?? cookMinutes
    }

    var tag: String? {
        nil
    }

    var likes: Int? {
        nil
    }

    var isUserCreated: Bool {
        get { sourceURLString == "user://local" }
        set {
            sourceURLString = newValue ? "user://local" : sourceURLString
        }
    }

    var ingredients: [String] {
        get {
            ingredientsText
                .split(separator: "\n")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
        }
        set {
            ingredientsText = newValue.joined(separator: "\n")
        }
    }

    func matchesSearchQuery(_ query: String) -> Bool {
        let normalizedQuery = Self.normalizedSearchFragment(query)
        guard !normalizedQuery.isEmpty else { return true }

        let titleText = Self.normalizedSearchFragment(title)
        let categoryText = Self.normalizedSearchFragment(category)
        let summary = Self.normalizedSearchFragment(summaryText)
        let ingredientText = ingredients
            .map(Self.normalizedIngredientLine)
            .joined(separator: " ")

        if titleText.contains(normalizedQuery) || ingredientText.contains(normalizedQuery) {
            return true
        }

        let tokens = Self.searchTokens(from: query)
        guard !tokens.isEmpty else { return false }

        return tokens.allSatisfy { token in
            titleText.contains(token)
                || ingredientText.contains(token)
                || categoryText.contains(token)
                || summary.contains(token)
        }
    }
}

private extension Recipe {
    static let ingredientNoiseWords: Set<String> = [
        "and", "black", "boneless", "breasts", "breast", "chopped", "clove", "cloves",
        "cups", "cup", "diced", "drained", "extra", "fillet", "fillets", "firm", "fresh",
        "grams", "garnish", "juice", "large", "lb", "lean", "medium", "minced", "oil",
        "optional", "oz", "pepper", "salt", "skinless", "small", "tablespoon", "tablespoons",
        "tbsp", "teaspoon", "teaspoons", "to", "taste", "tsp"
    ]

    static func normalizedSearchFragment(_ text: String) -> String {
        text
            .lowercased()
            .replacingOccurrences(
                of: "[^a-z0-9]+",
                with: " ",
                options: .regularExpression
            )
            .split(whereSeparator: \.isWhitespace)
            .joined(separator: " ")
    }

    static func normalizedIngredientLine(_ ingredient: String) -> String {
        normalizedSearchFragment(ingredient)
            .split(whereSeparator: \.isWhitespace)
            .filter { token in
                if token.allSatisfy(\.isNumber) {
                    return false
                }
                return !ingredientNoiseWords.contains(String(token))
            }
            .map(String.init)
            .joined(separator: " ")
    }

    static func searchTokens(from query: String) -> [String] {
        normalizedSearchFragment(query)
            .split(whereSeparator: \.isWhitespace)
            .map(String.init)
            .filter { !$0.isEmpty }
    }
}
