//
//  UserRecipesStore.swift
//  CookFlow
//
//  Created by Codex on 2/15/26.
//

import Foundation
import Combine

@MainActor
final class UserRecipesStore: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []

    private let storageKey = "cookflow.userRecipes"

    init() {
        load()
    }

    func addRecipe(
        title: String,
        summary: String,
        ingredients: [String],
        instructions: [String],
        imageData: Data?
    ) {
        let recipe = Recipe(
            id: UUID().uuidString,
            title: title,
            category: "My Recipes",
            summaryText: summary,
            heroImageName: Self.encodedHeroImageName(from: imageData),
            calories: nil,
            prepMinutes: nil,
            cookMinutes: nil,
            quantityText: "Serves 2",
            ingredientsText: ingredients.joined(separator: "\n"),
            instructionsText: instructions.joined(separator: "\n"),
            sourceURLString: "user://local",
            createdAt: Date()
        )

        recipes.insert(recipe, at: 0)
        persist()
    }

    func addImportedRecipe(_ dto: ExtractedRecipeDTO) -> Recipe {
        let title = dto.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let summary = "Imported from \(dto.sourceURL)"
        let prepMinutes = dto.prepTimeMinutes ?? dto.totalTimeMinutes
        let cookMinutes = dto.cookTimeMinutes
        let servings = parseServings(dto.servings)

        let recipe = Recipe(
            id: UUID().uuidString,
            title: title.isEmpty ? "Imported Recipe" : title,
            category: "My Recipes",
            summaryText: summary,
            heroImageName: "",
            calories: nil,
            prepMinutes: prepMinutes,
            cookMinutes: cookMinutes,
            quantityText: servings.map { "Serves \($0)" } ?? "Serves 2",
            ingredientsText: dto.ingredients.joined(separator: "\n"),
            instructionsText: dto.instructions.joined(separator: "\n"),
            sourceURLString: dto.sourceURL,
            createdAt: Date()
        )

        recipes.insert(recipe, at: 0)
        persist()
        return recipe
    }

    private func load() {
        guard let raw = UserDefaults.standard.string(forKey: storageKey),
              let data = raw.data(using: .utf8) else {
            recipes = []
            return
        }

        do {
            let decoded = try JSONDecoder().decode([UserRecipeRecord].self, from: data)
            recipes = decoded.map(\.recipe)
        } catch {
            recipes = []
        }
    }

    private func persist() {
        let records = recipes.map(UserRecipeRecord.init(recipe:))

        do {
            let data = try JSONEncoder().encode(records)
            let raw = String(data: data, encoding: .utf8) ?? "[]"
            UserDefaults.standard.set(raw, forKey: storageKey)
        } catch {
            UserDefaults.standard.set("[]", forKey: storageKey)
        }
    }

    private func parseServings(_ value: String?) -> Int? {
        guard let value else { return nil }
        let digits = value.compactMap { $0.isNumber ? $0 : nil }
        let number = String(digits)
        return Int(number)
    }

    private static func encodedHeroImageName(from imageData: Data?) -> String {
        guard let imageData else { return "" }
        return "base64:\(imageData.base64EncodedString())"
    }
}

private struct UserRecipeRecord: Codable {
    let id: String
    let title: String
    let category: String
    let summaryText: String
    let heroImageName: String
    let quantityText: String
    let prepMinutes: Int?
    let cookMinutes: Int?
    let ingredientsText: String
    let instructionsText: String
    let sourceURLString: String?
    let createdAt: Date

    init(recipe: Recipe) {
        id = recipe.id
        title = recipe.title
        category = recipe.category
        summaryText = recipe.summaryText
        heroImageName = recipe.heroImageName
        quantityText = recipe.quantityText
        prepMinutes = recipe.prepMinutes
        cookMinutes = recipe.cookMinutes
        ingredientsText = recipe.ingredientsText
        instructionsText = recipe.instructionsText
        sourceURLString = recipe.sourceURLString
        createdAt = recipe.createdAt
    }

    var recipe: Recipe {
        Recipe(
            id: id,
            title: title,
            category: category,
            summaryText: summaryText,
            heroImageName: heroImageName,
            calories: nil,
            prepMinutes: prepMinutes,
            cookMinutes: cookMinutes,
            quantityText: quantityText,
            ingredientsText: ingredientsText,
            instructionsText: instructionsText,
            sourceURLString: sourceURLString,
            createdAt: createdAt
        )
    }
}
