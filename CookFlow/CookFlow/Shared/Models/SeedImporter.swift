//
//  SeedImporter.swift
//  CookFlow
//
//  Created by Codex on 2/9/26.
//

import Foundation
import SwiftData

enum SeedImporter {
    private static let didImportKey = "didImportSeedV1"

    @MainActor
    static func importIfNeeded(modelContext: ModelContext) {
        if UserDefaults.standard.bool(forKey: didImportKey) {
            return
        }

        if let count = try? modelContext.fetchCount(FetchDescriptor<Recipe>()), count > 0 {
            UserDefaults.standard.set(true, forKey: didImportKey)
            return
        }

        let recipes = loadSeedRecipes() ?? fallbackRecipes()
        for recipe in recipes {
            modelContext.insert(recipe)
        }

        try? modelContext.save()
        UserDefaults.standard.set(true, forKey: didImportKey)
    }

    private static func loadSeedRecipes() -> [Recipe]? {
        guard let url = Bundle.main.url(forResource: "recipes_seed", withExtension: "json", subdirectory: "Seed") else {
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            return nil
        }

        let decoder = JSONDecoder()
        guard let seedRecipes = try? decoder.decode([SeedRecipe].self, from: data) else {
            return nil
        }

        return seedRecipes.map { seed in
            Recipe(
                title: seed.title,
                category: seed.category,
                heroImageName: seed.imageName ?? "",
                calories: seed.calories,
                prepMinutes: seed.prepMinutes,
                cookMinutes: nil,
                ingredientsText: seed.ingredients.joined(separator: "\n"),
                instructionsText: seed.instructions.joined(separator: "\n"),
                sourceURLString: nil,
                createdAt: Date()
            )
        }
    }

    private static func fallbackRecipes() -> [Recipe] {
        [
            Recipe(
                title: "Lemon Herb Chicken",
                category: "Quick Dinner Tips",
                heroImageName: "",
                calories: 420,
                prepMinutes: 25,
                cookMinutes: nil,
                ingredientsText: "2 chicken breasts\n1 lemon\n2 tbsp olive oil\n1 tsp garlic\nSalt & pepper",
                instructionsText: "Season the chicken.\nSear until golden.\nFinish with lemon and herbs.",
                sourceURLString: nil
            ),
            Recipe(
                title: "Green Goddess Salad",
                category: "Vegan",
                heroImageName: "",
                calories: 310,
                prepMinutes: 18,
                cookMinutes: nil,
                ingredientsText: "Mixed greens\nCucumber\nAvocado\nHerb dressing",
                instructionsText: "Chop vegetables.\nToss with dressing.\nServe chilled.",
                sourceURLString: nil
            ),
            Recipe(
                title: "Protein Burrito Bowl",
                category: "Meal prep",
                heroImageName: "",
                calories: 560,
                prepMinutes: 35,
                cookMinutes: nil,
                ingredientsText: "Brown rice\nBlack beans\nChicken\nSalsa",
                instructionsText: "Cook rice.\nWarm beans and chicken.\nAssemble bowls.",
                sourceURLString: nil
            ),
            Recipe(
                title: "Berry Oat Cups",
                category: "Breakfast",
                heroImageName: "",
                calories: 280,
                prepMinutes: 20,
                cookMinutes: nil,
                ingredientsText: "Rolled oats\nMilk\nMixed berries\nHoney",
                instructionsText: "Mix oats and milk.\nFold in berries.\nBake until set.",
                sourceURLString: nil
            )
        ]
    }
}

private struct SeedRecipe: Decodable {
    let title: String
    let category: String
    let calories: Int?
    let prepMinutes: Int?
    let imageName: String?
    let ingredients: [String]
    let instructions: [String]
}
