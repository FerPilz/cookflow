import Foundation

enum OptimizationPreference: String, CaseIterable, Identifiable {
    case prepTime = "Prep Time"
    case planning = "Planning"
    case proteinIntake = "Protein Intake"
    case budget = "Budget"
    case calories = "Calories"
    case variety = "Variety"

    var id: String { rawValue }
}
