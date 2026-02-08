//
//  SampleData.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Foundation

enum SampleData {
    static let sectionOrder: [String] = [
        "Top Picks for You",
        "Quick Dinner Tips",
        "Healthy and Under 500kcal",
        "Meal prep",
        "Breakfast",
        "Low carb",
        "Bread and Pastry",
        "High Protein",
        "Perfect Date Dinner",
        "Vegetarian",
        "Vegan",
        "Meat"
    ]

    static let categories: [Category] = [
        Category(title: "Top Picks for You", systemImageName: "star.fill"),
        Category(title: "Quick Dinner Tips", systemImageName: "bolt.fill"),
        Category(title: "Healthy and Under 500kcal", systemImageName: "leaf.fill"),
        Category(title: "Meal prep", systemImageName: "square.grid.2x2.fill"),
        Category(title: "Breakfast", systemImageName: "sunrise.fill"),
        Category(title: "Low carb", systemImageName: "drop.fill"),
        Category(title: "Bread and Pastry", systemImageName: "baguette"),
        Category(title: "High Protein", systemImageName: "bolt.heart.fill"),
        Category(title: "Perfect Date Dinner", systemImageName: "heart.fill"),
        Category(title: "Vegetarian", systemImageName: "leaf"),
        Category(title: "Vegan", systemImageName: "leaf.circle.fill"),
        Category(title: "Meat", systemImageName: "fork.knife")
    ]

    private static let imageA = URL(string: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=60")
    private static let imageB = URL(string: "https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=800&q=60")
    private static let imageC = URL(string: "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=800&q=60")

    static let recipesBySection: [String: [Recipe]] = [
        "Top Picks for You": [
            Recipe(title: "Miso Salmon Bowl", subtitle: "Savory glaze with sesame", category: "Top Picks for You", imageURL: imageA, tag: "Trending", durationMinutes: 25, likes: 1320),
            Recipe(title: "Chickpea Shawarma", subtitle: "Crispy spice rub", category: "Top Picks for You", imageURL: imageB, tag: "Vegan", durationMinutes: 30, likes: 980),
            Recipe(title: "Citrus Herb Chicken", subtitle: "Bright and juicy", category: "Top Picks for You", imageURL: imageC, tag: "New", durationMinutes: 28, likes: 860),
            Recipe(title: "Pesto Shrimp Skillet", subtitle: "One-pan dinner", category: "Top Picks for You", imageURL: nil, tag: "Quick", durationMinutes: 18, likes: 640),
            Recipe(title: "Roasted Veggie Bowl", subtitle: "Market-style mix", category: "Top Picks for You", imageURL: nil, tag: "Healthy", durationMinutes: 22, likes: 720),
            Recipe(title: "Teriyaki Beef Bites", subtitle: "Sweet soy finish", category: "Top Picks for You", imageURL: nil, tag: "Popular", durationMinutes: 24, likes: 1100)
        ],
        "Quick Dinner Tips": [
            Recipe(title: "15-Min Garlic Shrimp", subtitle: "Lemon butter", category: "Quick Dinner Tips", imageURL: imageA, tag: "15 min", durationMinutes: 15, likes: 540),
            Recipe(title: "Crispy Tofu Stir-Fry", subtitle: "Ginger soy", category: "Quick Dinner Tips", imageURL: nil, tag: "Vegan", durationMinutes: 20, likes: 480),
            Recipe(title: "One-Pan Pesto Chicken", subtitle: "Herby finish", category: "Quick Dinner Tips", imageURL: imageB, tag: "Easy", durationMinutes: 22, likes: 610),
            Recipe(title: "Speedy Turkey Tacos", subtitle: "Street-style", category: "Quick Dinner Tips", imageURL: nil, tag: "Family", durationMinutes: 18, likes: 520),
            Recipe(title: "Creamy Tomato Orzo", subtitle: "Comfort bowl", category: "Quick Dinner Tips", imageURL: nil, tag: "Vegetarian", durationMinutes: 19, likes: 430),
            Recipe(title: "Honey Soy Salmon", subtitle: "Sticky glaze", category: "Quick Dinner Tips", imageURL: imageC, tag: "Protein", durationMinutes: 20, likes: 690)
        ],
        "Healthy and Under 500kcal": [
            Recipe(title: "Lemon Herb Cod", subtitle: "Light and flaky", category: "Healthy and Under 500kcal", imageURL: imageC, tag: "Low cal", durationMinutes: 28, likes: 520),
            Recipe(title: "Zesty Quinoa Bowl", subtitle: "Citrus crunch", category: "Healthy and Under 500kcal", imageURL: nil, tag: "Vegan", durationMinutes: 25, likes: 430),
            Recipe(title: "Citrus Chicken Salad", subtitle: "Greens and citrus", category: "Healthy and Under 500kcal", imageURL: imageB, tag: "Fresh", durationMinutes: 20, likes: 480),
            Recipe(title: "Veggie Power Plate", subtitle: "Seasonal mix", category: "Healthy and Under 500kcal", imageURL: nil, tag: "Plant-based", durationMinutes: 30, likes: 390),
            Recipe(title: "Ginger Miso Soup", subtitle: "Cozy and light", category: "Healthy and Under 500kcal", imageURL: nil, tag: "Warm", durationMinutes: 18, likes: 300),
            Recipe(title: "Herbed Turkey Bowl", subtitle: "Lean protein", category: "Healthy and Under 500kcal", imageURL: imageA, tag: "Protein", durationMinutes: 26, likes: 410)
        ],
        "Meal prep": [
            Recipe(title: "Sunday Chili", subtitle: "Batch-friendly", category: "Meal prep", imageURL: imageA, tag: "Batch", durationMinutes: 40, likes: 880),
            Recipe(title: "Teriyaki Meal Boxes", subtitle: "Sweet soy", category: "Meal prep", imageURL: nil, tag: "Weekly", durationMinutes: 35, likes: 520),
            Recipe(title: "Roasted Veg Stack", subtitle: "Sheet pan", category: "Meal prep", imageURL: imageB, tag: "Vegan", durationMinutes: 30, likes: 460),
            Recipe(title: "Protein Burrito Bowls", subtitle: "Rice and beans", category: "Meal prep", imageURL: nil, tag: "High protein", durationMinutes: 45, likes: 610),
            Recipe(title: "Mediterranean Jars", subtitle: "No-heat lunches", category: "Meal prep", imageURL: imageC, tag: "Grab & go", durationMinutes: 20, likes: 420),
            Recipe(title: "Garlic Chicken Trays", subtitle: "Easy reheat", category: "Meal prep", imageURL: nil, tag: "Family", durationMinutes: 38, likes: 500)
        ],
        "Breakfast": [
            Recipe(title: "Berry Oat Cups", subtitle: "Make-ahead", category: "Breakfast", imageURL: imageB, tag: "Vegan", durationMinutes: 20, likes: 640),
            Recipe(title: "Spinach Egg Wrap", subtitle: "Protein bite", category: "Breakfast", imageURL: nil, tag: "Quick", durationMinutes: 15, likes: 410),
            Recipe(title: "Almond Chia Pudding", subtitle: "Overnight", category: "Breakfast", imageURL: imageC, tag: "Dairy-free", durationMinutes: 10, likes: 520),
            Recipe(title: "Banana Protein Pancakes", subtitle: "Fluffy stack", category: "Breakfast", imageURL: nil, tag: "Weekend", durationMinutes: 25, likes: 730),
            Recipe(title: "Smoky Hash Skillet", subtitle: "Crispy potatoes", category: "Breakfast", imageURL: imageA, tag: "Savory", durationMinutes: 22, likes: 460),
            Recipe(title: "Coconut Yogurt Bowl", subtitle: "Fresh fruit", category: "Breakfast", imageURL: nil, tag: "Light", durationMinutes: 8, likes: 300)
        ],
        "Low carb": [
            Recipe(title: "Cauli Fried Rice", subtitle: "Wok-style", category: "Low carb", imageURL: imageC, tag: "Low carb", durationMinutes: 22, likes: 510),
            Recipe(title: "Zucchini Lasagna", subtitle: "Cheesy layers", category: "Low carb", imageURL: nil, tag: "Comfort", durationMinutes: 35, likes: 620),
            Recipe(title: "Garlic Butter Steak", subtitle: "Pan-seared", category: "Low carb", imageURL: imageA, tag: "Protein", durationMinutes: 30, likes: 880),
            Recipe(title: "Avocado Chicken Bowl", subtitle: "Creamy crunch", category: "Low carb", imageURL: nil, tag: "Fresh", durationMinutes: 25, likes: 490),
            Recipe(title: "Herb Salmon Plate", subtitle: "Simple roast", category: "Low carb", imageURL: imageB, tag: "Omega-3", durationMinutes: 24, likes: 560),
            Recipe(title: "Broccoli Alfredo", subtitle: "Light cream", category: "Low carb", imageURL: nil, tag: "Vegetarian", durationMinutes: 28, likes: 430)
        ],
        "Bread and Pastry": [
            Recipe(title: "Cinnamon Brioche", subtitle: "Soft and sweet", category: "Bread and Pastry", imageURL: imageB, tag: "Bake", durationMinutes: 45, likes: 760),
            Recipe(title: "Olive Focaccia", subtitle: "Herby crust", category: "Bread and Pastry", imageURL: nil, tag: "Vegan", durationMinutes: 50, likes: 540),
            Recipe(title: "Sourdough Buns", subtitle: "Golden crust", category: "Bread and Pastry", imageURL: imageC, tag: "Artisan", durationMinutes: 60, likes: 680),
            Recipe(title: "Flaky Herb Biscuits", subtitle: "Buttery layers", category: "Bread and Pastry", imageURL: nil, tag: "Weekend", durationMinutes: 35, likes: 460),
            Recipe(title: "Maple Pecan Rolls", subtitle: "Sticky glaze", category: "Bread and Pastry", imageURL: imageA, tag: "Sweet", durationMinutes: 55, likes: 520),
            Recipe(title: "Rustic Seed Loaf", subtitle: "Hearty bite", category: "Bread and Pastry", imageURL: nil, tag: "Wholegrain", durationMinutes: 50, likes: 410)
        ],
        "High Protein": [
            Recipe(title: "Greek Power Bowl", subtitle: "Feta and olives", category: "High Protein", imageURL: imageA, tag: "Protein", durationMinutes: 25, likes: 920),
            Recipe(title: "Lean Turkey Skillet", subtitle: "Spiced and juicy", category: "High Protein", imageURL: nil, tag: "Weeknight", durationMinutes: 28, likes: 580),
            Recipe(title: "Salmon Protein Plate", subtitle: "Omega boost", category: "High Protein", imageURL: imageB, tag: "Healthy", durationMinutes: 30, likes: 720),
            Recipe(title: "Cottage Cheese Wrap", subtitle: "Quick bite", category: "High Protein", imageURL: nil, tag: "15 min", durationMinutes: 15, likes: 340),
            Recipe(title: "Steak Quinoa Bowl", subtitle: "Power grains", category: "High Protein", imageURL: imageC, tag: "Muscle", durationMinutes: 32, likes: 660),
            Recipe(title: "Spicy Tuna Stack", subtitle: "Light heat", category: "High Protein", imageURL: nil, tag: "Fresh", durationMinutes: 20, likes: 510)
        ],
        "Perfect Date Dinner": [
            Recipe(title: "Truffle Mushroom Pasta", subtitle: "Silky cream", category: "Perfect Date Dinner", imageURL: imageC, tag: "Date night", durationMinutes: 35, likes: 840),
            Recipe(title: "Seared Scallops", subtitle: "Golden crust", category: "Perfect Date Dinner", imageURL: nil, tag: "Elegant", durationMinutes: 28, likes: 780),
            Recipe(title: "Herb-Crusted Lamb", subtitle: "Rosemary rub", category: "Perfect Date Dinner", imageURL: imageA, tag: "Lux", durationMinutes: 45, likes: 690),
            Recipe(title: "Rosemary Gnocchi", subtitle: "Soft pillows", category: "Perfect Date Dinner", imageURL: nil, tag: "Italian", durationMinutes: 30, likes: 560),
            Recipe(title: "Butter Poached Salmon", subtitle: "Silky finish", category: "Perfect Date Dinner", imageURL: imageB, tag: "Seafood", durationMinutes: 32, likes: 610),
            Recipe(title: "Charred Asparagus", subtitle: "Lemon zest", category: "Perfect Date Dinner", imageURL: nil, tag: "Side", durationMinutes: 12, likes: 300)
        ],
        "Vegetarian": [
            Recipe(title: "Sweet Potato Tacos", subtitle: "Smoky salsa", category: "Vegetarian", imageURL: imageB, tag: "Meatless", durationMinutes: 25, likes: 710),
            Recipe(title: "Caprese Melt", subtitle: "Basil and tomato", category: "Vegetarian", imageURL: nil, tag: "Quick", durationMinutes: 20, likes: 420),
            Recipe(title: "Pesto Veg Bowl", subtitle: "Garden herbs", category: "Vegetarian", imageURL: imageC, tag: "Fresh", durationMinutes: 22, likes: 510),
            Recipe(title: "Mushroom Risotto", subtitle: "Creamy bite", category: "Vegetarian", imageURL: nil, tag: "Comfort", durationMinutes: 35, likes: 630),
            Recipe(title: "Spinach Ricotta Shells", subtitle: "Cheesy bake", category: "Vegetarian", imageURL: imageA, tag: "Bake", durationMinutes: 40, likes: 570),
            Recipe(title: "Crispy Halloumi Plate", subtitle: "Lemon drizzle", category: "Vegetarian", imageURL: nil, tag: "Salty", durationMinutes: 18, likes: 460)
        ],
        "Vegan": [
            Recipe(title: "Spiced Lentil Soup", subtitle: "Warm bowl", category: "Vegan", imageURL: imageA, tag: "Vegan", durationMinutes: 30, likes: 620),
            Recipe(title: "Coconut Curry", subtitle: "Creamy heat", category: "Vegan", imageURL: nil, tag: "Curry", durationMinutes: 28, likes: 580),
            Recipe(title: "Crispy Falafel", subtitle: "Tahini drizzle", category: "Vegan", imageURL: imageB, tag: "Mediterranean", durationMinutes: 35, likes: 690),
            Recipe(title: "Tofu Peanut Noodles", subtitle: "Nutty sauce", category: "Vegan", imageURL: nil, tag: "Quick", durationMinutes: 25, likes: 540),
            Recipe(title: "Green Goddess Salad", subtitle: "Herb dressing", category: "Vegan", imageURL: imageC, tag: "Fresh", durationMinutes: 18, likes: 410),
            Recipe(title: "Stuffed Sweet Potatoes", subtitle: "Smoky beans", category: "Vegan", imageURL: nil, tag: "Hearty", durationMinutes: 32, likes: 470)
        ],
        "Meat": [
            Recipe(title: "Smoky BBQ Ribs", subtitle: "Sticky glaze", category: "Meat", imageURL: imageB, tag: "BBQ", durationMinutes: 55, likes: 920),
            Recipe(title: "Garlic Butter Chicken", subtitle: "Sizzling skillet", category: "Meat", imageURL: nil, tag: "Weeknight", durationMinutes: 30, likes: 680),
            Recipe(title: "Steak Fajita Skillet", subtitle: "Pepper sear", category: "Meat", imageURL: imageA, tag: "Sizzle", durationMinutes: 35, likes: 740),
            Recipe(title: "Honey Glazed Pork", subtitle: "Sweet heat", category: "Meat", imageURL: nil, tag: "Roast", durationMinutes: 40, likes: 610),
            Recipe(title: "Crispy Chicken Cutlets", subtitle: "Golden crust", category: "Meat", imageURL: imageC, tag: "Comfort", durationMinutes: 28, likes: 570),
            Recipe(title: "Spiced Beef Bowls", subtitle: "Savory crunch", category: "Meat", imageURL: nil, tag: "Protein", durationMinutes: 26, likes: 520)
        ]
    ]

    static func recipes(for title: String) -> [Recipe] {
        recipesBySection[title] ?? []
    }

    static let allRecipes: [Recipe] = {
        recipesBySection.values.flatMap { $0 }
    }()
}
