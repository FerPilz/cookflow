import Foundation

enum GoalPreference: String, CaseIterable, Identifiable {
    case weightLoss = "Weight Loss"
    case muscleGain = "Muscle Gain"
    case maintain = "Maintain"
    case sugarLevelImprovement = "Sugar Level Improvement"
    case heartHealth = "Heart Health"
    case energy = "Energy"
    case betterSleep = "Better Sleep"
    case gutHealth = "Gut Health"

    var id: String { rawValue }
}
