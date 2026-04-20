import Foundation

enum FoodStylePreference: String, CaseIterable, Identifiable {
    case vegetarian = "Vegetarian"
    case carnivore = "Carnivore"
    case pescatarian = "Pescatarian"
    case vegan = "Vegan"
    case keto = "Keto"
    case mediterranean = "Mediterranean"
    case omnivore = "Omnivore"

    var id: String { rawValue }
}
