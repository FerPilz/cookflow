//
//  PlannerStore.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import Foundation
import Combine

enum PlannerMeal: String, CaseIterable, Hashable, Codable {
    case breakfast
    case lunch
    case snacks
    case dinner

    var title: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .snacks:
            return "Snacks"
        case .dinner:
            return "Dinner"
        }
    }
}

struct DayKey: Hashable, Codable {
    let startOfDay: Date

    init(_ date: Date, calendar: Calendar = .current) {
        self.startOfDay = calendar.startOfDay(for: date)
    }

    var date: Date { startOfDay }
}

struct RecipeRef: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let subtitle: String
    let imageName: String?
    let calories: Int?
}

@MainActor
final class PlannerStore: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var selectedMeal: PlannerMeal?
    @Published private(set) var assignments: [DayKey: [PlannerMeal: RecipeRef]] = [:]

    func assign(recipe: Recipe, to dayKey: DayKey, meal: PlannerMeal) {
        var dayAssignments = assignments[dayKey] ?? [:]
        dayAssignments[meal] = RecipeRef(
            id: recipe.id,
            title: recipe.title,
            subtitle: recipe.subtitle,
            imageName: recipe.imageName,
            calories: recipe.calories
        )
        assignments[dayKey] = dayAssignments
    }

    func remove(dayKey: DayKey, meal: PlannerMeal) {
        guard var dayAssignments = assignments[dayKey] else { return }
        dayAssignments[meal] = nil
        assignments[dayKey] = dayAssignments.isEmpty ? nil : dayAssignments
    }

    func meals(for dayKey: DayKey) -> [PlannerMeal: RecipeRef] {
        assignments[dayKey] ?? [:]
    }
}
