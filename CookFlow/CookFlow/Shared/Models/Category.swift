//
//  Category.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: UUID
    let title: String
    let systemImageName: String

    init(id: UUID = UUID(), title: String, systemImageName: String) {
        self.id = id
        self.title = title
        self.systemImageName = systemImageName
    }

    var slug: String {
        Category.metadataByTitle[title]?.slug
            ?? title
            .lowercased()
            .replacingOccurrences(of: "&", with: "and")
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "-")
    }

    var mappedSymbolName: String {
        Category.metadataByTitle[title]?.symbolName ?? systemImageName
    }
}

extension Category {
    struct Metadata: Hashable {
        let slug: String
        let symbolName: String
    }

    static let metadataByTitle: [String: Metadata] = [
        "Featured": Metadata(slug: "featured", symbolName: "star.fill"),
        "Community": Metadata(slug: "community", symbolName: "person.2.fill"),
        "Top Picks": Metadata(slug: "top-picks", symbolName: "hand.thumbsup.fill"),
        "AI Recommend": Metadata(slug: "ai-recommend", symbolName: "sparkles"),
        "Instagram Recipes": Metadata(slug: "instagram-recipes", symbolName: "camera.fill"),
        "Top Picks for You": Metadata(slug: "top-picks-for-you", symbolName: "star.fill"),
        "Quick Dinner Tips": Metadata(slug: "quick-dinner-tips", symbolName: "bolt.fill"),
        "Healthy and Under 500kcal": Metadata(slug: "healthy-under-500kcal", symbolName: "leaf.fill"),
        "Meal prep": Metadata(slug: "meal-prep", symbolName: "square.grid.2x2.fill"),
        "Breakfast": Metadata(slug: "breakfast", symbolName: "sunrise.fill"),
        "Low carb": Metadata(slug: "low-carb", symbolName: "drop.fill"),
        "Bread and Pastry": Metadata(slug: "bread-and-pastry", symbolName: "baguette"),
        "High Protein": Metadata(slug: "high-protein", symbolName: "bolt.heart.fill"),
        "Perfect Date Dinner": Metadata(slug: "perfect-date-dinner", symbolName: "heart.fill"),
        "Vegetarian": Metadata(slug: "vegetarian", symbolName: "leaf"),
        "Vegan": Metadata(slug: "vegan", symbolName: "leaf.circle.fill"),
        "Meat": Metadata(slug: "meat", symbolName: "fork.knife"),
        "Mediterranean": Metadata(slug: "mediterranean", symbolName: "sun.max.fill"),
        "Asian": Metadata(slug: "asian", symbolName: "takeoutbag.and.cup.and.straw.fill"),
        "Mexican": Metadata(slug: "mexican", symbolName: "tortilla.fill"),
        "Italian": Metadata(slug: "italian", symbolName: "fork.knife.circle"),
        "Desserts": Metadata(slug: "desserts", symbolName: "birthday.cake.fill"),
        "Drinks": Metadata(slug: "drinks", symbolName: "wineglass.fill"),
        "Cocktails": Metadata(slug: "cocktails", symbolName: "wineglass.fill"),
        "Snacks": Metadata(slug: "snacks", symbolName: "carrot.fill"),
        "World Cuisine": Metadata(slug: "world-cuisine", symbolName: "globe.americas.fill"),
        "Meat & Seafood": Metadata(slug: "meat-and-seafood", symbolName: "fish.fill"),
        "Goals": Metadata(slug: "goals", symbolName: "target"),
        "Date Night": Metadata(slug: "date-night", symbolName: "heart.fill"),
        "Bakery": Metadata(slug: "bakery", symbolName: "birthday.cake.fill"),
        "My Recipes": Metadata(slug: "my-recipes", symbolName: "book.closed.fill")
    ]
}
