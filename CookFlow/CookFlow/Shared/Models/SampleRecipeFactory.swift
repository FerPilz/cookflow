import Foundation

enum SampleRecipeFactory {
    static func makeSampleRecipes(for category: RecipeCategory) -> [Recipe] {
        if category == .snacks {
            return snackRecipes
        }

        if let curated = curatedRecipes(for: category) {
            return Array(curated.prefix(5))
        }

        let direct = SampleData.recipes(for: category)
        if !direct.isEmpty {
            return Array(direct.prefix(5))
        }

        if category == .drinks {
            let drinks = SampleData.recipes(for: "Drinks")
            if !drinks.isEmpty {
                return Array(drinks.prefix(5))
            }
        }

        let fallback = SampleData.allRecipes.filter { $0.category == category.rawValue }
        return Array(fallback.prefix(5))
    }

    private static func curatedRecipes(for category: RecipeCategory) -> [Recipe]? {
        let sectionTitles: [String]

        switch category {
        case .mediterranean:
            sectionTitles = ["Vegetarian", "Healthy and Under 500kcal", "Italian"]
        case .asian:
            sectionTitles = ["Meal prep", "High Protein", "Low carb"]
        case .mexican:
            sectionTitles = ["Meal prep", "Meat", "High Protein"]
        default:
            return nil
        }

        var seen = Set<String>()
        let recipes = sectionTitles
            .flatMap { SampleData.recipes(for: $0) }
            .filter { recipe in
                guard !seen.contains(recipe.id) else { return false }
                seen.insert(recipe.id)
                return true
            }

        return recipes.isEmpty ? nil : recipes
    }

    private static var snackRecipes: [Recipe] {
        [
            Recipe(
                id: "snk_001_greek_yogurt_berry_crunch",
                title: "Greek Yogurt Berry Crunch",
                category: "Snacks",
                summaryText: "Creamy yogurt bowl with berries, crunch, and a drizzle of honey.",
                heroImageName: "",
                calories: 240,
                prepMinutes: 8,
                cookMinutes: 0,
                quantityText: "Serves 1",
                ingredientsText: "Greek yogurt\nMixed berries\nGranola\nHoney",
                instructionsText: "Add yogurt to a bowl.\nTop with berries and granola.\nFinish with honey.",
                sourceURLString: nil
            ),
            Recipe(
                id: "snk_002_spicy_roasted_chickpeas",
                title: "Spicy Roasted Chickpeas",
                category: "Snacks",
                summaryText: "Crispy roasted chickpeas with smoky spices and sea salt.",
                heroImageName: "",
                calories: 210,
                prepMinutes: 10,
                cookMinutes: 22,
                quantityText: "Serves 2",
                ingredientsText: "Cooked chickpeas\nOlive oil\nPaprika\nCumin\nSalt",
                instructionsText: "Pat chickpeas dry.\nToss with oil and spices.\nRoast until crisp and golden.",
                sourceURLString: nil
            ),
            Recipe(
                id: "snk_003_apple_peanut_butter_stacks",
                title: "Apple Peanut Butter Stacks",
                category: "Snacks",
                summaryText: "Fresh apple rounds layered with peanut butter and seeds.",
                heroImageName: "",
                calories: 260,
                prepMinutes: 7,
                cookMinutes: 0,
                quantityText: "Serves 1",
                ingredientsText: "Apple\nPeanut butter\nChia seeds\nCinnamon",
                instructionsText: "Slice apple into rounds.\nSpread peanut butter.\nTop with seeds and cinnamon.",
                sourceURLString: nil
            ),
            Recipe(
                id: "snk_004_avocado_crackers",
                title: "Avocado Crackers",
                category: "Snacks",
                summaryText: "Whole grain crackers topped with avocado, lemon, and chili flakes.",
                heroImageName: "",
                calories: 230,
                prepMinutes: 6,
                cookMinutes: 0,
                quantityText: "Serves 1",
                ingredientsText: "Whole grain crackers\nAvocado\nLemon juice\nChili flakes\nSalt",
                instructionsText: "Mash avocado with lemon and salt.\nSpread over crackers.\nTop with chili flakes.",
                sourceURLString: nil
            ),
            Recipe(
                id: "snk_005_cottage_cheese_cucumber_boats",
                title: "Cottage Cheese Cucumber Boats",
                category: "Snacks",
                summaryText: "Hydrating cucumber boats filled with herby cottage cheese.",
                heroImageName: "",
                calories: 190,
                prepMinutes: 8,
                cookMinutes: 0,
                quantityText: "Serves 1",
                ingredientsText: "Cucumber\nCottage cheese\nDill\nBlack pepper",
                instructionsText: "Halve and scoop cucumber.\nFill with cottage cheese.\nSeason with dill and pepper.",
                sourceURLString: nil
            )
        ]
    }
}
