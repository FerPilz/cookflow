//
//  PlannerView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct PlannerView: View {
    @State private var selectedDate = Date()
    @State private var plannedMeals: [Date: [MealType: Recipe]] = [:]
    @State private var activeSlot: MealSlot?

    private let calendar = Calendar.current

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            WeekHeaderView(
                selectedDate: $selectedDate,
                weekDates: weekDates,
                onPreviousWeek: { shiftWeek(by: -1) },
                onNextWeek: { shiftWeek(by: 1) }
            )

            TableHeaderView()

            GeometryReader { geo in
                let rowSpacing: CGFloat = 6
                let rowHeight = max(1, (geo.size.height - rowSpacing * 6) / 7)

                VStack(spacing: rowSpacing) {
                    ForEach(weekDates, id: \.self) { date in
                        DayPlanRowView(
                            date: date,
                            rowHeight: rowHeight,
                            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                            meals: plannedMeals[dayKey(for: date)] ?? [:],
                            onSelectDay: { selectedDate = date },
                            onSelectMeal: { mealType in
                                activeSlot = MealSlot(date: dayKey(for: date), type: mealType)
                            },
                            onRemoveMeal: { mealType in
                                removeMeal(for: date, type: mealType)
                            },
                            caloriesForRecipe: calories(for:)
                        )
                    }
                }
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.top, DesignSystem.Spacing.md)
        .padding(.bottom, DesignSystem.Spacing.md)
        .background(DesignSystem.Colors.backgroundNearBlack)
        .sheet(item: $activeSlot) { slot in
            RecipePickerSheet(
                recipes: SampleData.allRecipes,
                onSelect: { recipe in
                    assign(recipe: recipe, to: slot)
                    activeSlot = nil
                }
            )
        }
    }

    private var weekDates: [Date] {
        guard let start = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start else {
            return [selectedDate]
        }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    private func shiftWeek(by weeks: Int) {
        if let newDate = calendar.date(byAdding: .day, value: weeks * 7, to: selectedDate) {
            selectedDate = newDate
        }
    }

    private func dayKey(for date: Date) -> Date {
        calendar.startOfDay(for: date)
    }

    private func assign(recipe: Recipe, to slot: MealSlot) {
        var dayMeals = plannedMeals[slot.date] ?? [:]
        dayMeals[slot.type] = recipe
        plannedMeals[slot.date] = dayMeals
    }

    private func removeMeal(for date: Date, type: MealType) {
        let key = dayKey(for: date)
        guard var dayMeals = plannedMeals[key] else { return }
        dayMeals[type] = nil
        plannedMeals[key] = dayMeals.isEmpty ? nil : dayMeals
    }

    private func calories(for recipe: Recipe) -> Int {
        if let calories = recipe.calories { return calories }
        if let duration = recipe.durationMinutes {
            return min(900, max(220, duration * 12))
        }
        return 420
    }
}

private enum MealType: CaseIterable, Hashable {
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

private enum PlannerLayout {
    static let dayColumnWidth: CGFloat = 56
    static let mealColumnWidth: CGFloat = 64
    static let mealBubbleSize: CGFloat = 48
}

private struct MealSlot: Identifiable {
    let date: Date
    let type: MealType

    var id: String {
        "\(date.timeIntervalSince1970)-\(type)"
    }
}

private struct WeekHeaderView: View {
    @Binding var selectedDate: Date
    let weekDates: [Date]
    let onPreviousWeek: () -> Void
    let onNextWeek: () -> Void

    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter
    }()

    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack {
                Button(action: onPreviousWeek) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .padding(8)
                        .background(DesignSystem.Colors.card)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                Spacer()

                Text(monthFormatter.string(from: selectedDate))
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                Spacer()

                Button(action: onNextWeek) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .padding(8)
                        .background(DesignSystem.Colors.card)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignSystem.Spacing.sm) {
                    ForEach(weekDates, id: \.self) { date in
                        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                        Button(action: { selectedDate = date }) {
                            VStack(spacing: 4) {
                                Text(weekdayFormatter.string(from: date))
                                    .font(DesignSystem.Fonts.valueProp)
                                Text("\(Calendar.current.component(.day, from: date))")
                                    .font(DesignSystem.Fonts.subtitle)
                            }
                            .foregroundColor(isSelected ? DesignSystem.Colors.backgroundNearBlack : DesignSystem.Colors.textCream)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .background(isSelected ? DesignSystem.Colors.textCream : DesignSystem.Colors.card)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

private struct DayPlanRowView: View {
    let date: Date
    let rowHeight: CGFloat
    let isSelected: Bool
    let meals: [MealType: Recipe]
    let onSelectDay: () -> Void
    let onSelectMeal: (MealType) -> Void
    let onRemoveMeal: (MealType) -> Void
    let caloriesForRecipe: (Recipe) -> Int

    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    var body: some View {
        Button(action: onSelectDay) {
            HStack(alignment: .top, spacing: DesignSystem.Spacing.sm) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(weekdayFormatter.string(from: date))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .lineLimit(1)

                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .lineLimit(1)
                }
                .frame(width: PlannerLayout.dayColumnWidth, alignment: .leading)

                HStack(spacing: DesignSystem.Spacing.xs) {
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        MealColumnView(
                            mealType: mealType,
                            recipe: meals[mealType],
                            onSelect: { onSelectMeal(mealType) },
                            onRemove: { onRemoveMeal(mealType) },
                            caloriesForRecipe: caloriesForRecipe
                        )
                    }
                }
            }
            .padding(DesignSystem.Spacing.sm)
            .frame(maxWidth: .infinity, minHeight: rowHeight, maxHeight: rowHeight)
            .background(isSelected ? DesignSystem.Colors.card.opacity(0.98) : DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(isSelected ? DesignSystem.Colors.ctaGreen.opacity(0.7) : DesignSystem.Colors.divider, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct MealColumnView: View {
    let mealType: MealType
    let recipe: Recipe?
    let onSelect: () -> Void
    let onRemove: () -> Void
    let caloriesForRecipe: (Recipe) -> Int

    var body: some View {
        Button(action: onSelect) {
            if let recipe = recipe {
                MealThumbnailView(recipe: recipe, calories: caloriesForRecipe(recipe), size: PlannerLayout.mealBubbleSize)
            } else {
                ZStack {
                    Circle()
                        .fill(DesignSystem.Colors.backgroundNearBlack.opacity(0.4))
                        .frame(width: PlannerLayout.mealBubbleSize, height: PlannerLayout.mealBubbleSize)
                        .overlay(
                            Circle()
                                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                        )

                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
            }
        }
        .buttonStyle(.plain)
        .contextMenu {
            if recipe != nil {
                Button(role: .destructive, action: onRemove) {
                    Text("Remove")
                }
            }
        }
        .frame(width: PlannerLayout.mealColumnWidth, alignment: .center)
    }
}

private struct TableHeaderView: View {
    var body: some View {
        HStack(spacing: DesignSystem.Spacing.xs) {
            Text("Day")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(DesignSystem.Colors.textMuted)
                .frame(width: PlannerLayout.dayColumnWidth, alignment: .leading)

            ForEach(MealType.allCases, id: \.self) { mealType in
                Text(mealType.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .frame(width: PlannerLayout.mealColumnWidth, alignment: .center)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 4)
    }
}

private struct MealThumbnailView: View {
    let recipe: Recipe
    let calories: Int?
    let size: CGFloat

    init(recipe: Recipe, calories: Int?, size: CGFloat = 36) {
        self.recipe = recipe
        self.calories = calories
        self.size = size
    }

    var body: some View {
        ZStack {
            if let url = recipe.imageURL {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
        .overlay(alignment: .bottomTrailing) {
            if let calories = calories {
                Text("\(calories)")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(DesignSystem.Colors.backgroundNearBlack.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .padding(2)
            }
        }
    }

    private var placeholder: some View {
        ZStack {
            LinearGradient(
                colors: [DesignSystem.Colors.card, DesignSystem.Colors.backgroundNearBlack],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: "fork.knife")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
    }
}

private struct RecipePickerSheet: View {
    let recipes: [Recipe]
    let onSelect: (Recipe) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Pick a recipe")
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                Spacer()

                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .buttonStyle(.plain)
            }

            SearchBar(text: $query, placeholder: "Search recipes")

            ScrollView {
                LazyVStack(spacing: DesignSystem.Spacing.sm) {
                    ForEach(filteredRecipes) { recipe in
                        Button(action: { onSelect(recipe) }) {
                            HStack(spacing: DesignSystem.Spacing.sm) {
                                MealThumbnailView(recipe: recipe, calories: nil)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(recipe.title)
                                        .font(DesignSystem.Fonts.subtitle)
                                        .foregroundColor(DesignSystem.Colors.textCream)

                                    Text(recipe.subtitle)
                                        .font(DesignSystem.Fonts.valueProp)
                                        .foregroundColor(DesignSystem.Colors.textMuted)
                                        .lineLimit(1)
                                }

                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, DesignSystem.Spacing.md)
                            .background(DesignSystem.Colors.card)
                            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(DesignSystem.Spacing.lg)
        .background(DesignSystem.Colors.backgroundNearBlack)
    }

    private var filteredRecipes: [Recipe] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return recipes }
        let lowercased = trimmed.lowercased()
        return recipes.filter { $0.title.lowercased().contains(lowercased) }
    }
}

#Preview {
    PlannerView()
        .preferredColorScheme(.dark)
}
