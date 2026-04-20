//
//  SampleData.swift
//  CookFlow
//
//  Generated from hero_images_batch.jsonl
//

import Foundation
#if DEBUG
import UIKit
#endif

enum SampleData {
    struct HomeSection: Identifiable, Hashable {
        let title: String
        let sourceTitle: String
        let systemImageName: String

        var id: String { title }
    }

    struct BrowseSection: Identifiable, Hashable {
        let title: String
        let items: [Category]

        var id: String { title }
    }

    struct SearchRecipeSection: Identifiable, Hashable {
        let title: String
        let recipeIDs: [String]

        var id: String { title }
    }

    static let sectionOrder: [String] = [
        "Top Picks for You",
        "Quick Dinner Tips",
        "Healthy and Under 500kcal",
        "Meal prep",
        "Perfect Date Dinner",
        "Breakfast",
        "Low carb",
        "Bread and Pastry",
        "High Protein",
        "Vegetarian",
        "Vegan",
        "Meat",
        "Mediterranean",
        "Asian",
        "Mexican",
        "Italian",
        "Desserts",
        "Cocktails",
    ]

    static let categories: [Category] = [
        Category(title: "Top Picks for You", systemImageName: "star.fill"),
        Category(title: "Quick Dinner Tips", systemImageName: "bolt.fill"),
        Category(title: "Healthy and Under 500kcal", systemImageName: "leaf.fill"),
        Category(title: "Meal prep", systemImageName: "square.grid.2x2.fill"),
        Category(title: "Perfect Date Dinner", systemImageName: "heart.fill"),
        Category(title: "Breakfast", systemImageName: "sunrise.fill"),
        Category(title: "Low carb", systemImageName: "drop.fill"),
        Category(title: "Bread and Pastry", systemImageName: "baguette"),
        Category(title: "High Protein", systemImageName: "bolt.heart.fill"),
        Category(title: "Vegetarian", systemImageName: "leaf"),
        Category(title: "Vegan", systemImageName: "leaf.circle.fill"),
        Category(title: "Meat", systemImageName: "fork.knife"),
        Category(title: "Mediterranean", systemImageName: "sun.max.fill"),
        Category(title: "Asian", systemImageName: "takeoutbag.and.cup.and.straw.fill"),
        Category(title: "Mexican", systemImageName: "tortilla.fill"),
        Category(title: "Italian", systemImageName: "fork.knife.circle"),
        Category(title: "Desserts", systemImageName: "birthday.cake.fill"),
        Category(title: "Cocktails", systemImageName: "wineglass.fill"),
        Category(title: "Snacks", systemImageName: "carrot.fill"),
    ]

    static let searchBrowseSections: [BrowseSection] = [
        BrowseSection(
            title: "World Cuisine",
            items: [
                Category(title: "Indian", systemImageName: "flame.fill"),
                Category(title: "Mexican", systemImageName: "tortilla.fill"),
                Category(title: "Korean", systemImageName: "takeoutbag.and.cup.and.straw.fill"),
                Category(title: "Italian", systemImageName: "fork.knife.circle"),
                Category(title: "Mediterranean", systemImageName: "sun.max.fill"),
                Category(title: "Asian", systemImageName: "globe.asia.australia.fill"),
            ]
        ),
        BrowseSection(
            title: "Meat & Seafood",
            items: [
                Category(title: "Fish", systemImageName: "fish.fill"),
                Category(title: "Meat", systemImageName: "fork.knife"),
                Category(title: "Seafood", systemImageName: "fork.knife.circle.fill"),
                Category(title: "Chicken", systemImageName: "bird.fill"),
                Category(title: "Beef", systemImageName: "takeoutbag.and.cup.and.straw.fill"),
                Category(title: "Salmon", systemImageName: "fish.circle.fill"),
            ]
        ),
        BrowseSection(
            title: "Goals",
            items: [
                Category(title: "Meal Prep", systemImageName: "square.grid.2x2.fill"),
                Category(title: "Weight Loss", systemImageName: "figure.walk"),
                Category(title: "Protein", systemImageName: "bolt.heart.fill"),
                Category(title: "Low Carb", systemImageName: "drop.fill"),
                Category(title: "Vegetarian", systemImageName: "leaf.fill"),
                Category(title: "Vegan", systemImageName: "leaf.circle.fill"),
            ]
        ),
        BrowseSection(
            title: "Date Night",
            items: [
                Category(title: "Cocktails", systemImageName: "wineglass.fill"),
                Category(title: "For Two", systemImageName: "person.2.fill"),
                Category(title: "Romance", systemImageName: "heart.fill"),
                Category(title: "Pasta Night", systemImageName: "fork.knife.circle"),
                Category(title: "Steakhouse", systemImageName: "flame.fill"),
                Category(title: "Desserts", systemImageName: "birthday.cake.fill"),
            ]
        ),
        BrowseSection(
            title: "Bakery",
            items: [
                Category(title: "Bread", systemImageName: "birthday.cake.fill"),
                Category(title: "Pastry", systemImageName: "birthday.cake"),
                Category(title: "Cakes", systemImageName: "birthday.cake.fill"),
                Category(title: "Cookies", systemImageName: "circle.hexagongrid.fill"),
                Category(title: "Brownies", systemImageName: "square.fill"),
                Category(title: "Cheesecake", systemImageName: "birthday.cake"),
            ]
        ),
    ]

    static let searchRecipeSections: [SearchRecipeSection] = [
        SearchRecipeSection(
            title: "World Cuisine",
            recipeIDs: [
                "pro_002_easy_butter_chicken_a",
                "vgn_003_chickpea_coconut_curry_c",
                "met_003_chicken_enchiladas_a",
                "hlt_002_chicken_fajita_rice_bake_b",
                "mlp_001_chicken_burrito_bowls_c",
                "vgn_002_spicy_sesame_tofu_stir_fry_b",
                "met_002_beef_stir_fry_a",
                "ita_001_worlds_best_lasagna_c",
                "ita_005_margherita_pizza_c"
            ]
        ),
        SearchRecipeSection(
            title: "Meat & Seafood",
            recipeIDs: [
                "lcb_002_sheet_pan_salmon_broccoli_b",
                "lcb_004_shrimp_scampi_zucchini_noodles_b",
                "hlt_004_garlic_butter_roasted_salmon_beets_broccoli_b",
                "met_001_easy_meatloaf_a",
                "met_002_beef_stir_fry_a",
                "met_003_chicken_enchiladas_a",
                "met_004_bbq_pulled_pork_sandwiches_a",
                "met_005_chicken_pot_pie_a",
                "dte_001_filet_mignon_red_wine_pan_sauce_a"
            ]
        ),
        SearchRecipeSection(
            title: "Goals",
            recipeIDs: [
                "mlp_001_chicken_burrito_bowls_c",
                "mlp_002_roasted_veggie_quinoa_salad_c",
                "mlp_003_overnight_oats_berries_c",
                "hlt_001_marry_me_white_bean_soup_kale_b",
                "hlt_003_chickpea_casserole_spinach_feta_b",
                "pro_001_chicken_chorizo_jambalaya_a",
                "pro_002_easy_butter_chicken_a",
                "pro_004_turkey_chili_a",
                "pro_005_salmon_quinoa_power_bowl_b"
            ]
        ),
        SearchRecipeSection(
            title: "Date Night",
            recipeIDs: [
                "dte_001_filet_mignon_red_wine_pan_sauce_a",
                "drk_001_margarita_a",
                "drk_002_new_york_sour_a",
                "drk_003_espresso_martini_a",
                "drk_004_negroni_a",
                "drk_005_old_fashioned_a",
                "ita_001_worlds_best_lasagna_c",
                "des_003_classic_tiramisu_c",
                "des_004_new_york_cheesecake_a"
            ]
        ),
        SearchRecipeSection(
            title: "Bakery",
            recipeIDs: [
                "bnp_001_banana_banana_bread_c",
                "bnp_002_big_and_bubbly_focaccia_c",
                "bnp_003_homemade_croissants_c",
                "bnp_004_breakfast_pastries_danish_style_c",
                "bnp_005_soft_cinnamon_rolls_c",
                "des_001_best_chocolate_chip_cookies_a",
                "des_002_best_brownies_a",
                "des_004_new_york_cheesecake_a",
                "des_005_lemon_bars_a"
            ]
        )
    ]

    static let homeSections: [HomeSection] = [
        HomeSection(title: "Featured", sourceTitle: "Top Picks for You", systemImageName: "star.fill"),
        HomeSection(title: "Community", sourceTitle: "Quick Dinner Tips", systemImageName: "person.2.fill"),
        HomeSection(title: "Top Picks", sourceTitle: "Healthy and Under 500kcal", systemImageName: "hand.thumbsup.fill"),
        HomeSection(title: "AI Recommend", sourceTitle: "Meal prep", systemImageName: "sparkles"),
        HomeSection(title: "Instagram Recipes", sourceTitle: "Perfect Date Dinner", systemImageName: "camera.fill"),
    ]

    private static let recipeSeeds: [RecipeSeed] = [
        RecipeSeed(
            id: "brk_001_good_old_fashioned_pancakes_b",
            title: "Good Old Fashioned Pancakes",
            category: "Breakfast",
            summary: "Classic good old fashioned pancakes with balanced flavor and practical steps.",
            servings: "Serves 2",
            prepMinutes: 12,
            cookMinutes: 12,
            calories: 400,
            ingredients: [
                "2 tbsp olive oil or butter",
                "4 large eggs",
                "1 cup milk or yogurt",
                "2 cups mixed fruit or vegetables",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
                "Fresh herbs, to finish",
            ],
            instructions: [
                "Prep ingredients and preheat a nonstick skillet over medium heat.",
                "Whisk wet ingredients, then fold in dry ingredients until just combined.",
                "Cook components in batches until golden and cooked through.",
                "Season to taste and adjust texture with a splash of water if needed.",
                "Plate warm and finish with fresh herbs or fruit.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=good-old-fashioned-pancakes",
            sections: [
                "Breakfast",
            ]
        ),
        RecipeSeed(
            id: "brk_002_eggs_benedict_b",
            title: "Eggs Benedict",
            category: "Breakfast",
            summary: "Classic eggs benedict with balanced flavor and practical steps.",
            servings: "Serves 2",
            prepMinutes: 12,
            cookMinutes: 12,
            calories: 412,
            ingredients: [
                "2 tbsp olive oil or butter",
                "4 large eggs",
                "1 cup milk or yogurt",
                "2 cups mixed fruit or vegetables",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
                "Fresh herbs, to finish",
            ],
            instructions: [
                "Prep ingredients and preheat a nonstick skillet over medium heat.",
                "Whisk wet ingredients, then fold in dry ingredients until just combined.",
                "Cook components in batches until golden and cooked through.",
                "Season to taste and adjust texture with a splash of water if needed.",
                "Plate warm and finish with fresh herbs or fruit.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=eggs-benedict",
            sections: [
                "Breakfast",
            ]
        ),
        RecipeSeed(
            id: "brk_003_avocado_toast_poached_egg_b",
            title: "Avocado Toast Poached Egg",
            category: "Breakfast",
            summary: "Classic avocado toast poached egg with balanced flavor and practical steps.",
            servings: "Serves 2",
            prepMinutes: 12,
            cookMinutes: 12,
            calories: 399,
            ingredients: [
                "2 slices sourdough bread",
                "1 ripe avocado",
                "2 large eggs",
                "1 tbsp lemon juice",
                "0.5 tsp red pepper flakes",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Prep ingredients and preheat a nonstick skillet over medium heat.",
                "Whisk wet ingredients, then fold in dry ingredients until just combined.",
                "Cook components in batches until golden and cooked through.",
                "Season to taste and adjust texture with a splash of water if needed.",
                "Plate warm and finish with fresh herbs or fruit.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=avocado-toast-poached-egg",
            sections: [
                "Breakfast",
            ]
        ),
        RecipeSeed(
            id: "brk_004_greek_yogurt_parfait_b",
            title: "Greek Yogurt Parfait",
            category: "Breakfast",
            summary: "Classic greek yogurt parfait with balanced flavor and practical steps.",
            servings: "Serves 2",
            prepMinutes: 12,
            cookMinutes: 12,
            calories: 429,
            ingredients: [
                "2 tbsp olive oil or butter",
                "4 large eggs",
                "1 cup milk or yogurt",
                "2 cups mixed fruit or vegetables",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
                "Fresh herbs, to finish",
            ],
            instructions: [
                "Prep ingredients and preheat a nonstick skillet over medium heat.",
                "Whisk wet ingredients, then fold in dry ingredients until just combined.",
                "Cook components in batches until golden and cooked through.",
                "Season to taste and adjust texture with a splash of water if needed.",
                "Plate warm and finish with fresh herbs or fruit.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=greek-yogurt-parfait",
            sections: [
                "Breakfast",
            ]
        ),
        RecipeSeed(
            id: "bnp_001_banana_banana_bread_c",
            title: "Banana Banana Bread",
            category: "Bread and Pastry",
            summary: "Classic banana banana bread with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 25,
            cookMinutes: 35,
            calories: 360,
            ingredients: [
                "3 cups all-purpose flour",
                "2.25 tsp instant yeast",
                "1 tsp kosher salt",
                "1 cup warm water or milk",
                "3 tbsp unsalted butter or olive oil",
                "1 tbsp sugar or honey",
            ],
            instructions: [
                "Mix dough ingredients until a shaggy dough forms.",
                "Knead 8 to 10 minutes until smooth and elastic.",
                "Let rise in a warm place until doubled.",
                "Shape, proof again, then bake until deeply golden.",
                "Cool on a rack before slicing or glazing.",
            ],
            sourceURL: "https://www.kingarthurbaking.com/search?query=banana-banana-bread",
            sections: [
                "Bread and Pastry",
            ]
        ),
        RecipeSeed(
            id: "bnp_002_big_and_bubbly_focaccia_c",
            title: "Big and Bubbly Focaccia",
            category: "Bread and Pastry",
            summary: "Classic big and bubbly focaccia with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 25,
            cookMinutes: 35,
            calories: 380,
            ingredients: [
                "3 cups all-purpose flour",
                "2.25 tsp instant yeast",
                "1 tsp kosher salt",
                "1 cup warm water or milk",
                "3 tbsp unsalted butter or olive oil",
                "1 tbsp sugar or honey",
            ],
            instructions: [
                "Mix dough ingredients until a shaggy dough forms.",
                "Knead 8 to 10 minutes until smooth and elastic.",
                "Let rise in a warm place until doubled.",
                "Shape, proof again, then bake until deeply golden.",
                "Cool on a rack before slicing or glazing.",
            ],
            sourceURL: "https://www.kingarthurbaking.com/search?query=big-and-bubbly-focaccia",
            sections: [
                "Bread and Pastry",
            ]
        ),
        RecipeSeed(
            id: "bnp_003_homemade_croissants_c",
            title: "Homemade Croissants",
            category: "Bread and Pastry",
            summary: "Classic homemade croissants with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 25,
            cookMinutes: 35,
            calories: 345,
            ingredients: [
                "3 cups all-purpose flour",
                "2.25 tsp instant yeast",
                "1 tsp kosher salt",
                "1 cup warm water or milk",
                "3 tbsp unsalted butter or olive oil",
                "1 tbsp sugar or honey",
            ],
            instructions: [
                "Mix dough ingredients until a shaggy dough forms.",
                "Knead 8 to 10 minutes until smooth and elastic.",
                "Let rise in a warm place until doubled.",
                "Shape, proof again, then bake until deeply golden.",
                "Cool on a rack before slicing or glazing.",
            ],
            sourceURL: "https://www.kingarthurbaking.com/search?query=homemade-croissants",
            sections: [
                "Bread and Pastry",
            ]
        ),
        RecipeSeed(
            id: "bnp_004_breakfast_pastries_danish_style_c",
            title: "Breakfast Pastries Danish Style",
            category: "Bread and Pastry",
            summary: "Classic breakfast pastries danish style with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 25,
            cookMinutes: 35,
            calories: 350,
            ingredients: [
                "3 cups all-purpose flour",
                "2.25 tsp instant yeast",
                "1 tsp kosher salt",
                "1 cup warm water or milk",
                "3 tbsp unsalted butter or olive oil",
                "1 tbsp sugar or honey",
            ],
            instructions: [
                "Mix dough ingredients until a shaggy dough forms.",
                "Knead 8 to 10 minutes until smooth and elastic.",
                "Let rise in a warm place until doubled.",
                "Shape, proof again, then bake until deeply golden.",
                "Cool on a rack before slicing or glazing.",
            ],
            sourceURL: "https://www.kingarthurbaking.com/search?query=breakfast-pastries-danish-style",
            sections: [
                "Bread and Pastry",
            ]
        ),
        RecipeSeed(
            id: "bnp_005_soft_cinnamon_rolls_c",
            title: "Soft Cinnamon Rolls",
            category: "Bread and Pastry",
            summary: "Classic soft cinnamon rolls with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 25,
            cookMinutes: 35,
            calories: 364,
            ingredients: [
                "3 cups all-purpose flour",
                "2.25 tsp instant yeast",
                "1 tsp kosher salt",
                "1 cup warm water or milk",
                "3 tbsp unsalted butter or olive oil",
                "1 tbsp sugar or honey",
            ],
            instructions: [
                "Mix dough ingredients until a shaggy dough forms.",
                "Knead 8 to 10 minutes until smooth and elastic.",
                "Let rise in a warm place until doubled.",
                "Shape, proof again, then bake until deeply golden.",
                "Cool on a rack before slicing or glazing.",
            ],
            sourceURL: "https://www.kingarthurbaking.com/search?query=soft-cinnamon-rolls",
            sections: [
                "Bread and Pastry",
            ]
        ),
        RecipeSeed(
            id: "lcb_001_garlic_butter_pork_chops_spinach_b",
            title: "Garlic Butter Pork Chops Spinach",
            category: "Low carb",
            summary: "Classic garlic butter pork chops spinach with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 465,
            ingredients: [
                "1.25 lb pork chops or shoulder",
                "1.5 lb protein of choice",
                "2 tbsp olive oil",
                "3 cloves garlic, minced",
                "3 cups low-carb vegetables",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Pat protein dry and season well with salt and pepper.",
                "Sear protein in hot oil until browned on both sides.",
                "Add garlic and vegetables; saute until tender-crisp.",
                "Deglaze with lemon juice and simmer briefly to coat.",
                "Rest protein 3 minutes, slice, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=garlic-butter-pork-chops-spinach",
            sections: [
                "Low carb",
            ]
        ),
        RecipeSeed(
            id: "lcb_002_sheet_pan_salmon_broccoli_b",
            title: "Sheet Pan Salmon Broccoli",
            category: "Low carb",
            summary: "Classic sheet pan salmon broccoli with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 486,
            ingredients: [
                "1 lb salmon fillet",
                "1.5 lb protein of choice",
                "2 tbsp olive oil",
                "3 cloves garlic, minced",
                "3 cups low-carb vegetables",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Pat protein dry and season well with salt and pepper.",
                "Sear protein in hot oil until browned on both sides.",
                "Add garlic and vegetables; saute until tender-crisp.",
                "Deglaze with lemon juice and simmer briefly to coat.",
                "Rest protein 3 minutes, slice, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=sheet-pan-salmon-broccoli",
            sections: [
                "Low carb",
            ]
        ),
        RecipeSeed(
            id: "lcb_003_one_pan_chicken_florentine_b",
            title: "One Pan Chicken Florentine",
            category: "Low carb",
            summary: "Classic one pan chicken florentine with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 498,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.5 lb protein of choice",
                "2 tbsp olive oil",
                "3 cloves garlic, minced",
                "3 cups low-carb vegetables",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Pat protein dry and season well with salt and pepper.",
                "Sear protein in hot oil until browned on both sides.",
                "Add garlic and vegetables; saute until tender-crisp.",
                "Deglaze with lemon juice and simmer briefly to coat.",
                "Rest protein 3 minutes, slice, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=one-pan-chicken-florentine",
            sections: [
                "Low carb",
                "Quick Dinner Tips",
            ]
        ),
        RecipeSeed(
            id: "lcb_004_shrimp_scampi_zucchini_noodles_b",
            title: "Shrimp Scampi Zucchini Noodles",
            category: "Low carb",
            summary: "Classic shrimp scampi zucchini noodles with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 476,
            ingredients: [
                "1.5 lb protein of choice",
                "2 tbsp olive oil",
                "3 cloves garlic, minced",
                "3 cups low-carb vegetables",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Pat protein dry and season well with salt and pepper.",
                "Sear protein in hot oil until browned on both sides.",
                "Add garlic and vegetables; saute until tender-crisp.",
                "Deglaze with lemon juice and simmer briefly to coat.",
                "Rest protein 3 minutes, slice, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=shrimp-scampi-zucchini-noodles",
            sections: [
                "Low carb",
                "Quick Dinner Tips",
            ]
        ),
        RecipeSeed(
            id: "lcb_005_cheesy_portobello_chicken_cutlets_broccoli_b",
            title: "Cheesy Portobello Chicken Cutlets Broccoli",
            category: "Low carb",
            summary: "Classic cheesy portobello chicken cutlets broccoli with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 461,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.5 lb protein of choice",
                "2 tbsp olive oil",
                "3 cloves garlic, minced",
                "3 cups low-carb vegetables",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Pat protein dry and season well with salt and pepper.",
                "Sear protein in hot oil until browned on both sides.",
                "Add garlic and vegetables; saute until tender-crisp.",
                "Deglaze with lemon juice and simmer briefly to coat.",
                "Rest protein 3 minutes, slice, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=cheesy-portobello-chicken-cutlets-broccoli",
            sections: [
                "Low carb",
            ]
        ),
        RecipeSeed(
            id: "pro_001_chicken_chorizo_jambalaya_a",
            title: "Chicken Chorizo Jambalaya",
            category: "High Protein",
            summary: "Classic chicken chorizo jambalaya with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 551,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.25 lb lean protein",
                "1 tbsp avocado oil",
                "1 cup cooked grains or legumes",
                "2 cups vegetables",
                "2 tbsp Greek yogurt or light sauce",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season protein and sear in hot oil until nearly cooked.",
                "Cook vegetables in the same pan with aromatics.",
                "Add grains or legumes and stir to combine.",
                "Finish with yogurt-based sauce or pan reduction.",
                "Portion into bowls and garnish with herbs.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=chicken-chorizo-jambalaya",
            sections: [
                "High Protein",
                "Quick Dinner Tips",
            ]
        ),
        RecipeSeed(
            id: "pro_002_easy_butter_chicken_a",
            title: "Easy Butter Chicken",
            category: "High Protein",
            summary: "Classic easy butter chicken with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 526,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.25 lb lean protein",
                "1 tbsp avocado oil",
                "1 cup cooked grains or legumes",
                "2 cups vegetables",
                "2 tbsp Greek yogurt or light sauce",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season protein and sear in hot oil until nearly cooked.",
                "Cook vegetables in the same pan with aromatics.",
                "Add grains or legumes and stir to combine.",
                "Finish with yogurt-based sauce or pan reduction.",
                "Portion into bowls and garnish with herbs.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=easy-butter-chicken",
            sections: [
                "High Protein",
                "Top Picks for You",
            ]
        ),
        RecipeSeed(
            id: "pro_003_turkey_chili_a",
            title: "Turkey Chili",
            category: "High Protein",
            summary: "Classic turkey chili with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 546,
            ingredients: [
                "1.25 lb lean protein",
                "1 tbsp avocado oil",
                "1 cup cooked grains or legumes",
                "2 cups vegetables",
                "2 tbsp Greek yogurt or light sauce",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season protein and sear in hot oil until nearly cooked.",
                "Cook vegetables in the same pan with aromatics.",
                "Add grains or legumes and stir to combine.",
                "Finish with yogurt-based sauce or pan reduction.",
                "Portion into bowls and garnish with herbs.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=turkey-chili",
            sections: [
                "High Protein",
            ]
        ),
        RecipeSeed(
            id: "pro_004_garlic_butter_steak_bites_veggies_a",
            title: "Garlic Butter Steak Bites Veggies",
            category: "High Protein",
            summary: "Classic garlic butter steak bites veggies with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 526,
            ingredients: [
                "1.25 lb beef steak strips",
                "1.25 lb lean protein",
                "1 tbsp avocado oil",
                "1 cup cooked grains or legumes",
                "2 cups vegetables",
                "2 tbsp Greek yogurt or light sauce",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season protein and sear in hot oil until nearly cooked.",
                "Cook vegetables in the same pan with aromatics.",
                "Add grains or legumes and stir to combine.",
                "Finish with yogurt-based sauce or pan reduction.",
                "Portion into bowls and garnish with herbs.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=garlic-butter-steak-bites-veggies",
            sections: [
                "High Protein",
            ]
        ),
        RecipeSeed(
            id: "pro_005_salmon_quinoa_power_bowl_b",
            title: "Salmon Quinoa Power Bowl",
            category: "High Protein",
            summary: "Classic salmon quinoa power bowl with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 20,
            calories: 526,
            ingredients: [
                "1 lb salmon fillet",
                "1.25 lb lean protein",
                "1 tbsp avocado oil",
                "1 cup cooked grains or legumes",
                "2 cups vegetables",
                "2 tbsp Greek yogurt or light sauce",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season protein and sear in hot oil until nearly cooked.",
                "Cook vegetables in the same pan with aromatics.",
                "Add grains or legumes and stir to combine.",
                "Finish with yogurt-based sauce or pan reduction.",
                "Portion into bowls and garnish with herbs.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=salmon-quinoa-power-bowl",
            sections: [
                "High Protein",
                "Meal prep",
            ]
        ),
        RecipeSeed(
            id: "veg_001_crispy_falafel_bowl_tabbouleh_b",
            title: "Crispy Falafel Bowl Tabbouleh",
            category: "Vegetarian",
            summary: "Classic crispy falafel bowl tabbouleh with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 437,
            ingredients: [
                "2 tbsp olive oil",
                "1 large onion, diced",
                "3 cloves garlic, minced",
                "2 cups hearty vegetables",
                "1 can beans or lentils",
                "1 tsp smoked paprika",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Saute onion and garlic in olive oil until fragrant.",
                "Add vegetables and cook until lightly caramelized.",
                "Stir in beans and spices; simmer until flavors meld.",
                "Adjust seasoning with salt, pepper, and acid.",
                "Serve hot with herbs and optional yogurt.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=crispy-falafel-bowl-tabbouleh",
            sections: [
                "Vegetarian",
                "Top Picks for You",
            ]
        ),
        RecipeSeed(
            id: "veg_002_hearty_vegetable_chili_b",
            title: "Hearty Vegetable Chili",
            category: "Vegetarian",
            summary: "Classic hearty vegetable chili with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 431,
            ingredients: [
                "2 tbsp olive oil",
                "1 large onion, diced",
                "3 cloves garlic, minced",
                "2 cups hearty vegetables",
                "1 can beans or lentils",
                "1 tsp smoked paprika",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Saute onion and garlic in olive oil until fragrant.",
                "Add vegetables and cook until lightly caramelized.",
                "Stir in beans and spices; simmer until flavors meld.",
                "Adjust seasoning with salt, pepper, and acid.",
                "Serve hot with herbs and optional yogurt.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=hearty-vegetable-chili",
            sections: [
                "Vegetarian",
                "Meal prep",
            ]
        ),
        RecipeSeed(
            id: "veg_003_black_bean_burgers_b",
            title: "Black Bean Burgers",
            category: "Vegetarian",
            summary: "Classic black bean burgers with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 443,
            ingredients: [
                "2 tbsp olive oil",
                "1 large onion, diced",
                "3 cloves garlic, minced",
                "2 cups hearty vegetables",
                "1 can beans or lentils",
                "1 tsp smoked paprika",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Saute onion and garlic in olive oil until fragrant.",
                "Add vegetables and cook until lightly caramelized.",
                "Stir in beans and spices; simmer until flavors meld.",
                "Adjust seasoning with salt, pepper, and acid.",
                "Serve hot with herbs and optional yogurt.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=black-bean-burgers",
            sections: [
                "Vegetarian",
            ]
        ),
        RecipeSeed(
            id: "veg_004_eggplant_parmesan_c",
            title: "Eggplant Parmesan",
            category: "Vegetarian",
            summary: "Classic eggplant parmesan with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 460,
            ingredients: [
                "2 tbsp olive oil",
                "1 large onion, diced",
                "3 cloves garlic, minced",
                "2 cups hearty vegetables",
                "1 can beans or lentils",
                "1 tsp smoked paprika",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Saute onion and garlic in olive oil until fragrant.",
                "Add vegetables and cook until lightly caramelized.",
                "Stir in beans and spices; simmer until flavors meld.",
                "Adjust seasoning with salt, pepper, and acid.",
                "Serve hot with herbs and optional yogurt.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=eggplant-parmesan",
            sections: [
                "Vegetarian",
            ]
        ),
        RecipeSeed(
            id: "veg_005_creamy_mushroom_stroganoff_c",
            title: "Creamy Mushroom Stroganoff",
            category: "Vegetarian",
            summary: "Classic creamy mushroom stroganoff with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 438,
            ingredients: [
                "2 tbsp olive oil",
                "1 large onion, diced",
                "3 cloves garlic, minced",
                "2 cups hearty vegetables",
                "1 can beans or lentils",
                "1 tsp smoked paprika",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Saute onion and garlic in olive oil until fragrant.",
                "Add vegetables and cook until lightly caramelized.",
                "Stir in beans and spices; simmer until flavors meld.",
                "Adjust seasoning with salt, pepper, and acid.",
                "Serve hot with herbs and optional yogurt.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=creamy-mushroom-stroganoff",
            sections: [
                "Vegetarian",
            ]
        ),
        RecipeSeed(
            id: "vgn_001_vegan_mushroom_stroganoff_c",
            title: "Vegan Mushroom Stroganoff",
            category: "Vegan",
            summary: "Classic vegan mushroom stroganoff with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 434,
            ingredients: [
                "2 tbsp olive oil",
                "1 onion, diced",
                "3 cloves garlic, minced",
                "1 can coconut milk or tomatoes",
                "2 cups vegetables",
                "1 cup chickpeas or tofu",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Sweat aromatics in olive oil over medium heat.",
                "Add vegetables and cook until starting to soften.",
                "Pour in coconut milk or tomatoes and simmer gently.",
                "Add tofu or chickpeas and cook until heated through.",
                "Finish with citrus, herbs, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=vegan-mushroom-stroganoff",
            sections: [
                "Vegan",
            ]
        ),
        RecipeSeed(
            id: "vgn_002_spicy_sesame_tofu_stir_fry_b",
            title: "Spicy Sesame Tofu Stir Fry",
            category: "Vegan",
            summary: "Classic spicy sesame tofu stir fry with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 424,
            ingredients: [
                "14 oz extra-firm tofu",
                "2 tbsp olive oil",
                "1 onion, diced",
                "3 cloves garlic, minced",
                "1 can coconut milk or tomatoes",
                "2 cups vegetables",
                "1 cup chickpeas or tofu",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Sweat aromatics in olive oil over medium heat.",
                "Add vegetables and cook until starting to soften.",
                "Pour in coconut milk or tomatoes and simmer gently.",
                "Add tofu or chickpeas and cook until heated through.",
                "Finish with citrus, herbs, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=spicy-sesame-tofu-stir-fry",
            sections: [
                "Vegan",
            ]
        ),
        RecipeSeed(
            id: "vgn_003_chickpea_coconut_curry_c",
            title: "Chickpea Coconut Curry",
            category: "Vegan",
            summary: "Classic chickpea coconut curry with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 416,
            ingredients: [
                "1 can chickpeas, drained",
                "2 tbsp olive oil",
                "1 onion, diced",
                "3 cloves garlic, minced",
                "1 can coconut milk or tomatoes",
                "2 cups vegetables",
                "1 cup chickpeas or tofu",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Sweat aromatics in olive oil over medium heat.",
                "Add vegetables and cook until starting to soften.",
                "Pour in coconut milk or tomatoes and simmer gently.",
                "Add tofu or chickpeas and cook until heated through.",
                "Finish with citrus, herbs, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=chickpea-coconut-curry",
            sections: [
                "Vegan",
            ]
        ),
        RecipeSeed(
            id: "vgn_004_vegan_shepherds_pie_c",
            title: "Vegan Shepherds Pie",
            category: "Vegan",
            summary: "Classic vegan shepherds pie with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 447,
            ingredients: [
                "2 tbsp olive oil",
                "1 onion, diced",
                "3 cloves garlic, minced",
                "1 can coconut milk or tomatoes",
                "2 cups vegetables",
                "1 cup chickpeas or tofu",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Sweat aromatics in olive oil over medium heat.",
                "Add vegetables and cook until starting to soften.",
                "Pour in coconut milk or tomatoes and simmer gently.",
                "Add tofu or chickpeas and cook until heated through.",
                "Finish with citrus, herbs, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=vegan-shepherds-pie",
            sections: [
                "Vegan",
            ]
        ),
        RecipeSeed(
            id: "vgn_005_chocolate_tahini_cookies_a",
            title: "Chocolate Tahini Cookies",
            category: "Vegan",
            summary: "Classic chocolate tahini cookies with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 25,
            calories: 432,
            ingredients: [
                "2 tbsp olive oil",
                "1 onion, diced",
                "3 cloves garlic, minced",
                "1 can coconut milk or tomatoes",
                "2 cups vegetables",
                "1 cup chickpeas or tofu",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Sweat aromatics in olive oil over medium heat.",
                "Add vegetables and cook until starting to soften.",
                "Pour in coconut milk or tomatoes and simmer gently.",
                "Add tofu or chickpeas and cook until heated through.",
                "Finish with citrus, herbs, and serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=chocolate-tahini-cookies",
            sections: [
                "Vegan",
            ]
        ),
        RecipeSeed(
            id: "met_001_easy_meatloaf_a",
            title: "Easy Meatloaf",
            category: "Meat",
            summary: "Classic easy meatloaf with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 599,
            ingredients: [
                "1.5 lb meat",
                "2 tbsp oil",
                "1 onion, sliced",
                "2 cups vegetables",
                "2 tsp spice blend",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season meat generously and brown in a hot pan.",
                "Saute onions and vegetables in rendered juices.",
                "Add spice blend and cook 30 seconds until aromatic.",
                "Return meat and simmer until tender and glazed.",
                "Rest briefly, then serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=easy-meatloaf",
            sections: [
                "Meat",
            ]
        ),
        RecipeSeed(
            id: "met_002_beef_stir_fry_a",
            title: "Beef Stir Fry",
            category: "Meat",
            summary: "Classic beef stir fry with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 609,
            ingredients: [
                "1.25 lb beef steak strips",
                "1.5 lb meat",
                "2 tbsp oil",
                "1 onion, sliced",
                "2 cups vegetables",
                "2 tsp spice blend",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season meat generously and brown in a hot pan.",
                "Saute onions and vegetables in rendered juices.",
                "Add spice blend and cook 30 seconds until aromatic.",
                "Return meat and simmer until tender and glazed.",
                "Rest briefly, then serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=beef-stir-fry",
            sections: [
                "Meat",
                "Top Picks for You",
                "Quick Dinner Tips",
            ]
        ),
        RecipeSeed(
            id: "met_003_chicken_enchiladas_a",
            title: "Chicken Enchiladas",
            category: "Meat",
            summary: "Classic chicken enchiladas with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 595,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.5 lb meat",
                "2 tbsp oil",
                "1 onion, sliced",
                "2 cups vegetables",
                "2 tsp spice blend",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season meat generously and brown in a hot pan.",
                "Saute onions and vegetables in rendered juices.",
                "Add spice blend and cook 30 seconds until aromatic.",
                "Return meat and simmer until tender and glazed.",
                "Rest briefly, then serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=chicken-enchiladas",
            sections: [
                "Meat",
            ]
        ),
        RecipeSeed(
            id: "met_004_bbq_pulled_pork_sandwiches_a",
            title: "Bbq Pulled Pork Sandwiches",
            category: "Meat",
            summary: "Classic bbq pulled pork sandwiches with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 628,
            ingredients: [
                "1.25 lb pork chops or shoulder",
                "1.5 lb meat",
                "2 tbsp oil",
                "1 onion, sliced",
                "2 cups vegetables",
                "2 tsp spice blend",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season meat generously and brown in a hot pan.",
                "Saute onions and vegetables in rendered juices.",
                "Add spice blend and cook 30 seconds until aromatic.",
                "Return meat and simmer until tender and glazed.",
                "Rest briefly, then serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=bbq-pulled-pork-sandwiches",
            sections: [
                "Meat",
            ]
        ),
        RecipeSeed(
            id: "met_005_chicken_pot_pie_a",
            title: "Chicken Pot Pie",
            category: "Meat",
            summary: "Classic chicken pot pie with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 600,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.5 lb meat",
                "2 tbsp oil",
                "1 onion, sliced",
                "2 cups vegetables",
                "2 tsp spice blend",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Season meat generously and brown in a hot pan.",
                "Saute onions and vegetables in rendered juices.",
                "Add spice blend and cook 30 seconds until aromatic.",
                "Return meat and simmer until tender and glazed.",
                "Rest briefly, then serve.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=chicken-pot-pie",
            sections: [
                "Meat",
            ]
        ),
        RecipeSeed(
            id: "des_001_best_chocolate_chip_cookies_a",
            title: "Best Chocolate Chip Cookies",
            category: "Desserts",
            summary: "Classic best chocolate chip cookies with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 20,
            cookMinutes: 28,
            calories: 384,
            ingredients: [
                "2 cups flour",
                "1 cup sugar",
                "0.5 cup butter",
                "2 large eggs",
                "1 tsp vanilla extract",
                "1 tsp baking powder",
                "0.25 tsp salt",
            ],
            instructions: [
                "Preheat oven and prepare pan with parchment.",
                "Cream butter and sugar until light.",
                "Mix in eggs and vanilla, then fold in dry ingredients.",
                "Bake until set and lightly golden on top.",
                "Cool completely before slicing or serving.",
            ],
            sourceURL: "https://sallysbakingaddiction.com/?s=best-chocolate-chip-cookies",
            sections: [
                "Desserts",
            ]
        ),
        RecipeSeed(
            id: "des_002_best_brownies_a",
            title: "Best Brownies",
            category: "Desserts",
            summary: "Classic best brownies with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 20,
            cookMinutes: 28,
            calories: 388,
            ingredients: [
                "2 cups flour",
                "1 cup sugar",
                "0.5 cup butter",
                "2 large eggs",
                "1 tsp vanilla extract",
                "1 tsp baking powder",
                "0.25 tsp salt",
            ],
            instructions: [
                "Preheat oven and prepare pan with parchment.",
                "Cream butter and sugar until light.",
                "Mix in eggs and vanilla, then fold in dry ingredients.",
                "Bake until set and lightly golden on top.",
                "Cool completely before slicing or serving.",
            ],
            sourceURL: "https://sallysbakingaddiction.com/?s=best-brownies",
            sections: [
                "Desserts",
            ]
        ),
        RecipeSeed(
            id: "des_003_classic_tiramisu_c",
            title: "Classic Tiramisu",
            category: "Desserts",
            summary: "Classic classic tiramisu with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 20,
            cookMinutes: 28,
            calories: 376,
            ingredients: [
                "2 cups flour",
                "1 cup sugar",
                "0.5 cup butter",
                "2 large eggs",
                "1 tsp vanilla extract",
                "1 tsp baking powder",
                "0.25 tsp salt",
            ],
            instructions: [
                "Preheat oven and prepare pan with parchment.",
                "Cream butter and sugar until light.",
                "Mix in eggs and vanilla, then fold in dry ingredients.",
                "Bake until set and lightly golden on top.",
                "Cool completely before slicing or serving.",
            ],
            sourceURL: "https://sallysbakingaddiction.com/?s=classic-tiramisu",
            sections: [
                "Desserts",
                "Perfect Date Dinner",
            ]
        ),
        RecipeSeed(
            id: "des_004_new_york_cheesecake_a",
            title: "New York Cheesecake",
            category: "Desserts",
            summary: "Classic new york cheesecake with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 20,
            cookMinutes: 28,
            calories: 375,
            ingredients: [
                "2 cups flour",
                "1 cup sugar",
                "0.5 cup butter",
                "2 large eggs",
                "1 tsp vanilla extract",
                "1 tsp baking powder",
                "0.25 tsp salt",
            ],
            instructions: [
                "Preheat oven and prepare pan with parchment.",
                "Cream butter and sugar until light.",
                "Mix in eggs and vanilla, then fold in dry ingredients.",
                "Bake until set and lightly golden on top.",
                "Cool completely before slicing or serving.",
            ],
            sourceURL: "https://sallysbakingaddiction.com/?s=new-york-cheesecake",
            sections: [
                "Desserts",
                "Top Picks for You",
            ]
        ),
        RecipeSeed(
            id: "des_005_lemon_bars_a",
            title: "Lemon Bars",
            category: "Desserts",
            summary: "Classic lemon bars with balanced flavor and practical steps.",
            servings: "Serves 8",
            prepMinutes: 20,
            cookMinutes: 28,
            calories: 379,
            ingredients: [
                "2 cups flour",
                "1 cup sugar",
                "0.5 cup butter",
                "2 large eggs",
                "1 tsp vanilla extract",
                "1 tsp baking powder",
                "0.25 tsp salt",
            ],
            instructions: [
                "Preheat oven and prepare pan with parchment.",
                "Cream butter and sugar until light.",
                "Mix in eggs and vanilla, then fold in dry ingredients.",
                "Bake until set and lightly golden on top.",
                "Cool completely before slicing or serving.",
            ],
            sourceURL: "https://sallysbakingaddiction.com/?s=lemon-bars",
            sections: [
                "Desserts",
            ]
        ),
        RecipeSeed(
            id: "ita_001_worlds_best_lasagna_c",
            title: "Worlds Best Lasagna",
            category: "Italian",
            summary: "Classic worlds best lasagna with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 18,
            cookMinutes: 24,
            calories: 572,
            ingredients: [
                "12 oz pasta or dough",
                "2 tbsp olive oil",
                "3 cloves garlic",
                "1 cup tomato or cream base",
                "0.5 cup grated parmesan",
                "Fresh basil or parsley",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Bring salted water to a boil or preheat oven as needed.",
                "Cook pasta or base until al dente or partially cooked.",
                "Build sauce with olive oil, garlic, and tomatoes or cream.",
                "Toss together and finish with cheese and herbs.",
                "Serve immediately while hot.",
            ],
            sourceURL: "https://www.seriouseats.com/search?q=worlds-best-lasagna",
            sections: [
                "Italian",
                "Top Picks for You",
            ]
        ),
        RecipeSeed(
            id: "ita_002_cacio_e_pepe_c",
            title: "Cacio E Pepe",
            category: "Italian",
            summary: "Classic cacio e pepe with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 18,
            cookMinutes: 24,
            calories: 566,
            ingredients: [
                "12 oz pasta or dough",
                "2 tbsp olive oil",
                "3 cloves garlic",
                "1 cup tomato or cream base",
                "0.5 cup grated parmesan",
                "Fresh basil or parsley",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Bring salted water to a boil or preheat oven as needed.",
                "Cook pasta or base until al dente or partially cooked.",
                "Build sauce with olive oil, garlic, and tomatoes or cream.",
                "Toss together and finish with cheese and herbs.",
                "Serve immediately while hot.",
            ],
            sourceURL: "https://www.seriouseats.com/search?q=cacio-e-pepe",
            sections: [
                "Italian",
                "Perfect Date Dinner",
            ]
        ),
        RecipeSeed(
            id: "ita_003_spaghetti_carbonara_c",
            title: "Spaghetti Carbonara",
            category: "Italian",
            summary: "Classic spaghetti carbonara with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 18,
            cookMinutes: 24,
            calories: 561,
            ingredients: [
                "12 oz pasta or dough",
                "2 tbsp olive oil",
                "3 cloves garlic",
                "1 cup tomato or cream base",
                "0.5 cup grated parmesan",
                "Fresh basil or parsley",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Bring salted water to a boil or preheat oven as needed.",
                "Cook pasta or base until al dente or partially cooked.",
                "Build sauce with olive oil, garlic, and tomatoes or cream.",
                "Toss together and finish with cheese and herbs.",
                "Serve immediately while hot.",
            ],
            sourceURL: "https://www.seriouseats.com/search?q=spaghetti-carbonara",
            sections: [
                "Italian",
                "Perfect Date Dinner",
            ]
        ),
        RecipeSeed(
            id: "ita_004_chicken_parmesan_c",
            title: "Chicken Parmesan",
            category: "Italian",
            summary: "Classic chicken parmesan with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 18,
            cookMinutes: 24,
            calories: 564,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "12 oz pasta or dough",
                "2 tbsp olive oil",
                "3 cloves garlic",
                "1 cup tomato or cream base",
                "0.5 cup grated parmesan",
                "Fresh basil or parsley",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Bring salted water to a boil or preheat oven as needed.",
                "Cook pasta or base until al dente or partially cooked.",
                "Build sauce with olive oil, garlic, and tomatoes or cream.",
                "Toss together and finish with cheese and herbs.",
                "Serve immediately while hot.",
            ],
            sourceURL: "https://www.seriouseats.com/search?q=chicken-parmesan",
            sections: [
                "Italian",
            ]
        ),
        RecipeSeed(
            id: "ita_005_margherita_pizza_c",
            title: "Margherita Pizza",
            category: "Italian",
            summary: "Classic margherita pizza with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 18,
            cookMinutes: 24,
            calories: 562,
            ingredients: [
                "12 oz pasta or dough",
                "2 tbsp olive oil",
                "3 cloves garlic",
                "1 cup tomato or cream base",
                "0.5 cup grated parmesan",
                "Fresh basil or parsley",
                "Salt and pepper, to taste",
            ],
            instructions: [
                "Bring salted water to a boil or preheat oven as needed.",
                "Cook pasta or base until al dente or partially cooked.",
                "Build sauce with olive oil, garlic, and tomatoes or cream.",
                "Toss together and finish with cheese and herbs.",
                "Serve immediately while hot.",
            ],
            sourceURL: "https://www.seriouseats.com/search?q=margherita-pizza",
            sections: [
                "Italian",
            ]
        ),
        RecipeSeed(
            id: "hlt_001_marry_me_white_bean_soup_kale_b",
            title: "Marry Me White Bean Soup Kale",
            category: "Healthy and Under 500kcal",
            summary: "Classic marry me white bean soup kale with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 22,
            calories: 440,
            ingredients: [
                "1 tbsp olive oil",
                "1 lb lean protein or legumes",
                "3 cups vegetables",
                "1 cup whole grains or beans",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Prep all vegetables and protein before heating pan.",
                "Cook protein or legumes with minimal oil until done.",
                "Add vegetables and cook until tender but bright.",
                "Season with citrus, salt, and pepper.",
                "Serve with whole grains or beans for balance.",
            ],
            sourceURL: "https://www.eatingwell.com/search?q=marry-me-white-bean-soup-kale",
            sections: [
                "Healthy and Under 500kcal",
                "Healthy and Under 500kcal",
            ]
        ),
        RecipeSeed(
            id: "hlt_002_chicken_fajita_rice_bake_b",
            title: "Chicken Fajita Rice Bake",
            category: "Healthy and Under 500kcal",
            summary: "Classic chicken fajita rice bake with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 22,
            calories: 452,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1 tbsp olive oil",
                "1 lb lean protein or legumes",
                "3 cups vegetables",
                "1 cup whole grains or beans",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Prep all vegetables and protein before heating pan.",
                "Cook protein or legumes with minimal oil until done.",
                "Add vegetables and cook until tender but bright.",
                "Season with citrus, salt, and pepper.",
                "Serve with whole grains or beans for balance.",
            ],
            sourceURL: "https://www.eatingwell.com/search?q=chicken-fajita-rice-bake",
            sections: [
                "Healthy and Under 500kcal",
                "Quick Dinner Tips",
                "Healthy and Under 500kcal",
            ]
        ),
        RecipeSeed(
            id: "hlt_003_chickpea_casserole_spinach_feta_b",
            title: "Chickpea Casserole Spinach Feta",
            category: "Healthy and Under 500kcal",
            summary: "Classic chickpea casserole spinach feta with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 22,
            calories: 447,
            ingredients: [
                "1 can chickpeas, drained",
                "1 tbsp olive oil",
                "1 lb lean protein or legumes",
                "3 cups vegetables",
                "1 cup whole grains or beans",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Prep all vegetables and protein before heating pan.",
                "Cook protein or legumes with minimal oil until done.",
                "Add vegetables and cook until tender but bright.",
                "Season with citrus, salt, and pepper.",
                "Serve with whole grains or beans for balance.",
            ],
            sourceURL: "https://www.eatingwell.com/search?q=chickpea-casserole-spinach-feta",
            sections: [
                "Healthy and Under 500kcal",
                "Healthy and Under 500kcal",
            ]
        ),
        RecipeSeed(
            id: "hlt_004_garlic_butter_roasted_salmon_beets_broccoli_b",
            title: "Garlic Butter Roasted Salmon Beets Broccoli",
            category: "Healthy and Under 500kcal",
            summary: "Classic garlic butter roasted salmon beets broccoli with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 22,
            calories: 451,
            ingredients: [
                "1 lb salmon fillet",
                "1 tbsp olive oil",
                "1 lb lean protein or legumes",
                "3 cups vegetables",
                "1 cup whole grains or beans",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Prep all vegetables and protein before heating pan.",
                "Cook protein or legumes with minimal oil until done.",
                "Add vegetables and cook until tender but bright.",
                "Season with citrus, salt, and pepper.",
                "Serve with whole grains or beans for balance.",
            ],
            sourceURL: "https://www.eatingwell.com/search?q=garlic-butter-roasted-salmon-beets-broccoli",
            sections: [
                "Healthy and Under 500kcal",
                "Healthy and Under 500kcal",
            ]
        ),
        RecipeSeed(
            id: "hlt_005_french_onion_skillet_beans_b",
            title: "French Onion Skillet Beans",
            category: "Healthy and Under 500kcal",
            summary: "Classic french onion skillet beans with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 15,
            cookMinutes: 22,
            calories: 456,
            ingredients: [
                "1 tbsp olive oil",
                "1 lb lean protein or legumes",
                "3 cups vegetables",
                "1 cup whole grains or beans",
                "1 tbsp lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Prep all vegetables and protein before heating pan.",
                "Cook protein or legumes with minimal oil until done.",
                "Add vegetables and cook until tender but bright.",
                "Season with citrus, salt, and pepper.",
                "Serve with whole grains or beans for balance.",
            ],
            sourceURL: "https://www.eatingwell.com/search?q=french-onion-skillet-beans",
            sections: [
                "Healthy and Under 500kcal",
                "Healthy and Under 500kcal",
            ]
        ),
        RecipeSeed(
            id: "mlp_001_chicken_burrito_bowls_c",
            title: "Chicken Burrito Bowls",
            category: "Meal prep",
            summary: "Classic chicken burrito bowls with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 524,
            ingredients: [
                "1.25 lb chicken thighs or breasts",
                "1.5 lb protein or legumes",
                "2 cups cooked grains",
                "3 cups vegetables",
                "2 tbsp olive oil",
                "1 tbsp vinegar or lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Cook protein in batches and cool slightly.",
                "Roast or saute vegetables until tender.",
                "Prepare grains and dressing separately.",
                "Portion into meal-prep containers evenly.",
                "Store chilled for up to 4 days.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=chicken-burrito-bowls",
            sections: [
                "Meal prep",
                "Meal prep",
            ]
        ),
        RecipeSeed(
            id: "mlp_002_roasted_veggie_quinoa_salad_c",
            title: "Roasted Veggie Quinoa Salad",
            category: "Meal prep",
            summary: "Classic roasted veggie quinoa salad with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 509,
            ingredients: [
                "1.5 lb protein or legumes",
                "2 cups cooked grains",
                "3 cups vegetables",
                "2 tbsp olive oil",
                "1 tbsp vinegar or lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Cook protein in batches and cool slightly.",
                "Roast or saute vegetables until tender.",
                "Prepare grains and dressing separately.",
                "Portion into meal-prep containers evenly.",
                "Store chilled for up to 4 days.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=roasted-veggie-quinoa-salad",
            sections: [
                "Meal prep",
                "Meal prep",
            ]
        ),
        RecipeSeed(
            id: "mlp_003_overnight_oats_berries_b",
            title: "Overnight Oats Berries",
            category: "Meal prep",
            summary: "Classic overnight oats berries with balanced flavor and practical steps.",
            servings: "Serves 4",
            prepMinutes: 20,
            cookMinutes: 30,
            calories: 520,
            ingredients: [
                "1.5 lb protein or legumes",
                "2 cups cooked grains",
                "3 cups vegetables",
                "2 tbsp olive oil",
                "1 tbsp vinegar or lemon juice",
                "1 tsp kosher salt",
                "0.5 tsp black pepper",
            ],
            instructions: [
                "Cook protein in batches and cool slightly.",
                "Roast or saute vegetables until tender.",
                "Prepare grains and dressing separately.",
                "Portion into meal-prep containers evenly.",
                "Store chilled for up to 4 days.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=overnight-oats-berries",
            sections: [
                "Meal prep",
                "Meal prep",
            ]
        ),
        RecipeSeed(
            id: "dte_001_filet_mignon_red_wine_pan_sauce_a",
            title: "Filet Mignon Red Wine Pan Sauce",
            category: "Perfect Date Dinner",
            summary: "Classic filet mignon red wine pan sauce with balanced flavor and practical steps.",
            servings: "Serves 2",
            prepMinutes: 20,
            cookMinutes: 18,
            calories: 658,
            ingredients: [
                "2 filet mignon steaks",
                "1 tbsp neutral oil",
                "2 tbsp butter",
                "2 cloves garlic",
                "0.5 cup dry red wine",
                "0.5 cup beef stock",
                "Salt and black pepper",
            ],
            instructions: [
                "Pat steaks dry and season generously.",
                "Sear steaks in a hot pan, then baste with butter and garlic.",
                "Rest steaks while making pan sauce.",
                "Deglaze pan with red wine and reduce with stock.",
                "Slice steaks and spoon sauce over top.",
            ],
            sourceURL: "https://www.allrecipes.com/search?q=filet-mignon-red-wine-pan-sauce",
            sections: [
                "Perfect Date Dinner",
                "Perfect Date Dinner",
            ]
        ),
        RecipeSeed(
            id: "drk_001_margarita_a",
            title: "Margarita",
            category: "Drinks",
            summary: "Bright tequila cocktail with orange liqueur and fresh lime.",
            servings: "Makes 1 cocktail",
            prepMinutes: 5,
            cookMinutes: 0,
            calories: 210,
            ingredients: [
                "2 oz blanco tequila",
                "1 oz Cointreau",
                "1 oz fresh lime juice",
                "0.25 oz agave syrup",
                "Ice cubes",
                "Lime wheel, for garnish",
                "Kosher salt, for rim (optional)",
            ],
            instructions: [
                "Rim half of a rocks glass with lime and dip in salt if desired.",
                "Fill a shaker with ice, tequila, Cointreau, lime juice, and agave.",
                "Shake hard for about 12 seconds until well chilled.",
                "Strain over fresh ice in the prepared glass.",
                "Garnish with a lime wheel and serve immediately.",
            ],
            sourceURL: "https://www.liquor.com/recipes/margarita/",
            sections: [
                "Drinks",
            ]
        ),
        RecipeSeed(
            id: "drk_002_new_york_sour_a",
            title: "New York Sour",
            category: "Drinks",
            summary: "A whiskey sour finished with a float of dry red wine.",
            servings: "Makes 1 cocktail",
            prepMinutes: 6,
            cookMinutes: 0,
            calories: 235,
            ingredients: [
                "2 oz bourbon",
                "0.75 oz fresh lemon juice",
                "0.75 oz simple syrup",
                "1 small egg white (optional)",
                "0.5 oz dry red wine",
                "Ice cubes",
                "Lemon peel, for garnish",
            ],
            instructions: [
                "Add bourbon, lemon juice, simple syrup, and egg white to a shaker.",
                "Dry shake for 10 seconds, then add ice and shake again.",
                "Double strain into a rocks glass over fresh ice.",
                "Slowly float red wine over the back of a spoon.",
                "Garnish with a lemon peel and serve.",
            ],
            sourceURL: "https://www.liquor.com/recipes/new-york-sour/",
            sections: [
                "Drinks",
                "Perfect Date Dinner",
            ]
        ),
        RecipeSeed(
            id: "drk_003_espresso_martini_a",
            title: "Espresso Martini",
            category: "Drinks",
            summary: "Vodka, espresso, and coffee liqueur shaken to a creamy foam.",
            servings: "Makes 1 cocktail",
            prepMinutes: 6,
            cookMinutes: 0,
            calories: 195,
            ingredients: [
                "2 oz vodka",
                "1 oz coffee liqueur",
                "1 oz fresh espresso",
                "0.25 oz simple syrup",
                "Ice cubes",
                "3 coffee beans, for garnish",
            ],
            instructions: [
                "Brew espresso and let it cool slightly for 1 minute.",
                "Add vodka, coffee liqueur, espresso, and syrup to a shaker with ice.",
                "Shake vigorously for 15 seconds to build foam.",
                "Double strain into a chilled coupe glass.",
                "Garnish with three coffee beans.",
            ],
            sourceURL: "https://www.liquor.com/recipes/espresso-martini/",
            sections: [
                "Drinks",
            ]
        ),
        RecipeSeed(
            id: "drk_004_negroni_a",
            title: "Negroni",
            category: "Drinks",
            summary: "The classic equal-parts gin, Campari, and sweet vermouth cocktail.",
            servings: "Makes 1 cocktail",
            prepMinutes: 4,
            cookMinutes: 0,
            calories: 175,
            ingredients: [
                "1 oz gin",
                "1 oz Campari",
                "1 oz sweet vermouth",
                "Ice cubes",
                "Orange peel, for garnish",
            ],
            instructions: [
                "Fill a mixing glass with ice.",
                "Add gin, Campari, and sweet vermouth.",
                "Stir for 20 seconds until cold and diluted.",
                "Strain into a rocks glass over a large ice cube.",
                "Express orange peel over the drink and garnish.",
            ],
            sourceURL: "https://www.liquor.com/recipes/negroni/",
            sections: [
                "Drinks",
            ]
        ),
        RecipeSeed(
            id: "drk_005_old_fashioned_a",
            title: "Old Fashioned",
            category: "Drinks",
            summary: "Bourbon with sugar and bitters, stirred over ice.",
            servings: "Makes 1 cocktail",
            prepMinutes: 5,
            cookMinutes: 0,
            calories: 185,
            ingredients: [
                "2 oz bourbon",
                "0.25 oz simple syrup",
                "2 dashes Angostura bitters",
                "1 dash orange bitters",
                "Ice cubes",
                "Orange peel, for garnish",
            ],
            instructions: [
                "Add bourbon, syrup, and bitters to a mixing glass with ice.",
                "Stir for 20 seconds until chilled.",
                "Strain into a rocks glass over a large cube.",
                "Express orange peel oils over the top.",
                "Garnish with the peel and serve.",
            ],
            sourceURL: "https://www.liquor.com/recipes/bourbon-old-fashioned/",
            sections: [
                "Drinks",
            ]
        ),
    ]

    static let allRecipes: [Recipe] = recipeSeeds.map { $0.recipe }

    static let recipesBySection: [String: [Recipe]] = {
        var grouped: [String: [Recipe]] = [:]
        for section in sectionOrder {
            grouped[section] = recipeSeeds
                .filter { seed in
                    if section == "Cocktails" {
                        return seed.sections.contains("Cocktails") || seed.sections.contains("Drinks")
                    }
                    return seed.sections.contains(section)
                }
                .map(\.recipe)
        }
        return grouped
    }()

    static func recipes(for title: String) -> [Recipe] {
        if let recipes = recipesBySection[title], !recipes.isEmpty {
            return recipes
        }

        switch title {
        case "Mediterranean":
            return SampleRecipeFactory.makeSampleRecipes(for: .mediterranean)
        case "Asian":
            return SampleRecipeFactory.makeSampleRecipes(for: .asian)
        case "Mexican":
            return SampleRecipeFactory.makeSampleRecipes(for: .mexican)
        default:
            return []
        }
    }

    static func recipes(for category: RecipeCategory) -> [Recipe] {
        if category == .drinks {
            return recipes(for: "Cocktails")
        }
        return recipes(for: category.rawValue)
    }

    static func recipes(forBrowseCategoryTitle title: String) -> [Recipe] {
        switch title {
        case "Indian":
            return recipes(matchingIDs: [
                "pro_002_easy_butter_chicken_a",
                "vgn_003_chickpea_coconut_curry_c"
            ])
        case "Mexican":
            return recipes(matchingIDs: [
                "met_003_chicken_enchiladas_a",
                "hlt_002_chicken_fajita_rice_bake_b",
                "mlp_001_chicken_burrito_bowls_c"
            ])
        case "Korean":
            return recipes(matchingIDs: [
                "vgn_002_spicy_sesame_tofu_stir_fry_b",
                "met_002_beef_stir_fry_a"
            ])
        case "Italian":
            return recipes(for: "Italian")
        case "Mediterranean":
            return recipes(matchingIDs: [
                "pro_005_salmon_quinoa_power_bowl_b",
                "mlp_002_roasted_veggie_quinoa_salad_c",
                "hlt_003_chickpea_casserole_spinach_feta_b"
            ])
        case "Asian":
            return recipes(matchingIDs: [
                "vgn_002_spicy_sesame_tofu_stir_fry_b",
                "met_002_beef_stir_fry_a",
                "pro_002_easy_butter_chicken_a"
            ])
        case "Fish":
            return recipes(matchingIDs: [
                "lcb_002_sheet_pan_salmon_broccoli_b",
                "pro_005_salmon_quinoa_power_bowl_b",
                "hlt_004_garlic_butter_roasted_salmon_beets_broccoli_b"
            ])
        case "Meat":
            return recipes(for: "Meat")
        case "Seafood":
            return recipes(matchingIDs: [
                "lcb_004_shrimp_scampi_zucchini_noodles_b",
                "lcb_002_sheet_pan_salmon_broccoli_b",
                "hlt_004_garlic_butter_roasted_salmon_beets_broccoli_b"
            ])
        case "Chicken":
            return recipes(matchingIDs: [
                "met_005_chicken_pot_pie_a",
                "hlt_002_chicken_fajita_rice_bake_b",
                "pro_001_chicken_chorizo_jambalaya_a"
            ])
        case "Beef":
            return recipes(matchingIDs: [
                "met_002_beef_stir_fry_a",
                "met_001_easy_meatloaf_a",
                "dte_001_filet_mignon_red_wine_pan_sauce_a"
            ])
        case "Salmon":
            return recipes(matchingIDs: [
                "lcb_002_sheet_pan_salmon_broccoli_b",
                "hlt_004_garlic_butter_roasted_salmon_beets_broccoli_b",
                "pro_005_salmon_quinoa_power_bowl_b"
            ])
        case "Meal Prep":
            return recipes(for: "Meal prep")
        case "Weight Loss":
            return recipes(for: "Healthy and Under 500kcal")
        case "Protein":
            return recipes(for: "High Protein")
        case "Low Carb":
            return recipes(for: "Low carb")
        case "Vegetarian":
            return recipes(matchingIDs: [
                "hlt_003_chickpea_casserole_spinach_feta_b",
                "mlp_002_roasted_veggie_quinoa_salad_c",
                "hlt_005_french_onion_skillet_beans_b"
            ])
        case "Vegan":
            return recipes(matchingIDs: [
                "vgn_001_vegan_mushroom_stroganoff_c",
                "vgn_002_spicy_sesame_tofu_stir_fry_b",
                "vgn_003_chickpea_coconut_curry_c"
            ])
        case "Cocktails":
            return recipes(for: "Cocktails")
        case "For Two":
            return recipes(for: "Perfect Date Dinner").filter { $0.quantityText == "Serves 2" }
        case "Romance":
            return recipes(for: "Perfect Date Dinner")
        case "Pasta Night":
            return recipes(matchingIDs: [
                "ita_001_worlds_best_lasagna_c",
                "ita_002_cacio_e_pepe_c",
                "ita_003_spaghetti_carbonara_c"
            ])
        case "Steakhouse":
            return recipes(matchingIDs: [
                "dte_001_filet_mignon_red_wine_pan_sauce_a",
                "met_001_easy_meatloaf_a",
                "pro_004_garlic_butter_steak_bites_veggies_a"
            ])
        case "Desserts":
            return recipes(matchingIDs: [
                "des_003_classic_tiramisu_c",
                "des_004_new_york_cheesecake_a",
                "des_005_lemon_bars_a"
            ])
        case "Bread":
            return recipes(matchingIDs: [
                "bnp_001_banana_banana_bread_c",
                "bnp_002_big_and_bubbly_focaccia_c"
            ])
        case "Pastry":
            return recipes(matchingIDs: [
                "bnp_003_homemade_croissants_c",
                "bnp_004_breakfast_pastries_danish_style_c",
                "bnp_005_soft_cinnamon_rolls_c"
            ])
        case "Cakes":
            return recipes(matchingIDs: [
                "des_003_classic_tiramisu_c",
                "des_004_new_york_cheesecake_a"
            ])
        case "Cookies":
            return recipes(matchingIDs: [
                "des_001_best_chocolate_chip_cookies_a",
                "vgn_005_chocolate_tahini_cookies_a"
            ])
        case "Brownies":
            return recipes(matchingIDs: [
                "des_002_best_brownies_a",
                "des_005_lemon_bars_a"
            ])
        case "Cheesecake":
            return recipes(matchingIDs: [
                "des_004_new_york_cheesecake_a",
                "des_003_classic_tiramisu_c"
            ])
        default:
            return recipes(for: title)
        }
    }

    static func thumbnailImageName(forBrowseCategoryTitle title: String) -> String? {
        recipes(forBrowseCategoryTitle: title)
            .first(where: { !$0.heroImageName.isEmpty })?
            .heroImageName
    }

    static func recipes(forSearchSectionTitle title: String) -> [Recipe] {
        guard let section = searchRecipeSections.first(where: { $0.title == title }) else {
            return []
        }
        return recipes(matchingIDs: section.recipeIDs)
    }

    static func topLevelSearchCategories(includeMyRecipes: Bool) -> [Category] {
        var categories = searchRecipeSections.map { section in
            Category(
                title: section.title,
                systemImageName: Category.metadataByTitle[section.title]?.symbolName ?? "circle.fill"
            )
        }

        if includeMyRecipes {
            categories.append(
                Category(
                    title: "My Recipes",
                    systemImageName: Category.metadataByTitle["My Recipes"]?.symbolName ?? "book.closed.fill"
                )
            )
        }

        return categories
    }

    static func homeCategories() -> [Category] {
        homeSections.map { section in
            Category(title: section.title, systemImageName: section.systemImageName)
        }
    }

    static func recipes(forHomeSectionTitle title: String, userRecipes: [Recipe]) -> [Recipe] {
        if title == "My Recipes" {
            return Array(
                userRecipes
                    .sorted { $0.createdAt > $1.createdAt }
                    .prefix(9)
            )
        }

        let sourceTitle = homeSections.first(where: { $0.title == title })?.sourceTitle ?? title
        return recipes(for: sourceTitle)
    }

#if DEBUG
    static func validateHeroAssets() {
        let missing = allRecipes
            .map(\.heroImageName)
            .filter { !$0.isEmpty && UIImage(named: $0) == nil }
        if missing.isEmpty {
            print("[SampleData] All hero image assets found (\(allRecipes.count)).")
        } else {
            print("[SampleData] Missing hero image assets: \(missing)")
        }
    }
#endif

    private static func recipes(matchingIDs ids: [String]) -> [Recipe] {
        ids.compactMap { id in
            allRecipes.first(where: { $0.id == id })
        }
    }
}

private struct RecipeSeed {
    let id: String
    let title: String
    let category: String
    let summary: String
    let servings: String
    let prepMinutes: Int
    let cookMinutes: Int
    let calories: Int
    let ingredients: [String]
    let instructions: [String]
    let sourceURL: String
    let sections: [String]

    var recipe: Recipe {
        Recipe(
            id: id,
            title: title,
            category: category,
            summaryText: summary,
            heroImageName: id,
            calories: calories,
            prepMinutes: prepMinutes,
            cookMinutes: cookMinutes,
            quantityText: servings,
            ingredientsText: ingredients.joined(separator: "\n"),
            instructionsText: instructions.joined(separator: "\n"),
            sourceURLString: sourceURL
        )
    }
}
