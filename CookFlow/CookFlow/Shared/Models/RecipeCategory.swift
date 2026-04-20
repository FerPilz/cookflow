//
//  RecipeCategory.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import Foundation

enum RecipeCategory: String, CaseIterable {
    case topPicks = "Top Picks for You"
    case quickDinner = "Quick Dinner Tips"
    case healthy = "Healthy and Under 500kcal"
    case mealPrep = "Meal prep"
    case breakfast = "Breakfast"
    case lowCarb = "Low carb"
    case breadAndPastry = "Bread and Pastry"
    case highProtein = "High Protein"
    case dateDinner = "Perfect Date Dinner"
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case meat = "Meat"
    case mediterranean = "Mediterranean"
    case asian = "Asian"
    case mexican = "Mexican"
    case desserts = "Desserts"
    case italian = "Italian"
    case drinks = "Cocktails"
    case snacks = "Snacks"

    static func from(categoryTitle: String) -> RecipeCategory {
        if categoryTitle == "Drinks" {
            return .drinks
        }
        return RecipeCategory(rawValue: categoryTitle) ?? .topPicks
    }
}
