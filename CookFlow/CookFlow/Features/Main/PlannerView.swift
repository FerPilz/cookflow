//
//  PlannerView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct PlannerView: View {
    @EnvironmentObject private var plannerStore: PlannerStore
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var activeSlot: MealSlot?
    @State private var isCalendarExpanded = false
    @State private var selectedDayKeys: Set<DayKey> = []
    @State private var focusedDayKey: DayKey?

    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.minimumDaysInFirstWeek = 4
        return calendar
    }

    var body: some View {
        let colors = themeManager.palette

        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 6) {
                    WeekHeaderView(
                        selectedDate: Binding(
                            get: { plannerStore.selectedDate },
                            set: { plannerStore.selectedDate = $0 }
                        ),
                        visibleDayKeys: topSelectorDayKeys,
                        selectedDayKeys: selectedDayKeys,
                        focusedDayKey: focusedDayKey,
                        calendar: calendar,
                        isCalendarExpanded: $isCalendarExpanded,
                        onPrimaryTapDay: { dayKey in
                            focusRow(for: dayKey, proxy: proxy)
                        },
                        onPreviousWeek: {
                            if isCalendarExpanded {
                                shiftMonth(by: -1)
                            } else {
                                shiftWeek(by: -1)
                            }
                        },
                        onNextWeek: {
                            if isCalendarExpanded {
                                shiftMonth(by: 1)
                            } else {
                                shiftWeek(by: 1)
                            }
                        }
                    )

                    if isCalendarExpanded {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                            Text("Tap for one day, drag for a range.")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(DesignSystem.Colors.textMuted)
                                .lineLimit(1)

                            PlannerMonthCalendarView(
                                visibleMonthDate: plannerStore.selectedDate,
                                selectedDayKeys: selectedDayKeys,
                                plannedDayKeys: plannedDayKeys,
                                calendar: calendar,
                                onTapDate: handleCalendarTap,
                                onDragRange: handleCalendarRangeDrag,
                                onVisibleMonthChange: handleVisibleMonthChange
                            )
                        }
                        .padding(.horizontal, DesignSystem.Spacing.sm)
                        .padding(.top, DesignSystem.Spacing.sm)
                        .padding(.bottom, 2)
                        .background(colors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        if plannerDayKeys.isEmpty {
                            Text("Select one or more days from the calendar to build your plan.")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(DesignSystem.Colors.textMuted)
                                .padding(.horizontal, 4)
                        } else {
                            TableHeaderView()
                        }

                        LazyVStack(spacing: DesignSystem.Spacing.xs) {
                            ForEach(Array(plannerDayKeys.enumerated()), id: \.element) { index, dayKey in
                                DayPlanRowView(
                                    date: dayKey.date,
                                    dayIndex: index,
                                    rowHeight: 74,
                                    isSelected: selectedDayKeys.contains(dayKey),
                                    isFocused: focusedDayKey == dayKey,
                                    meals: plannerStore.meals(for: dayKey),
                                    onSelectDay: {
                                        toggleDayFromPlannerRow(dayKey)
                                        focusRow(for: dayKey, proxy: proxy)
                                    },
                                    onSelectMeal: { meal in
                                        plannerStore.selectedMeal = meal
                                        activeSlot = MealSlot(dayKey: dayKey, meal: meal)
                                    },
                                    onRemoveMeal: { meal in
                                        plannerStore.remove(dayKey: dayKey, meal: meal)
                                    },
                                    onRemoveDay: { removeSelectedDay(dayKey) }
                                )
                                .id(dayKey)
                            }
                        }

                    }
                    .padding(.top, 1)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, 40)
            }
            .onChange(of: focusedDayKey) { _, newValue in
                guard let dayKey = newValue else { return }
                withAnimation(.easeInOut(duration: 0.24)) {
                    proxy.scrollTo(dayKey, anchor: .center)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(colors.background)
        .navigationDestination(item: $activeSlot) { slot in
            SearchView(
                selectionTitle: "Select recipe for \(slot.title)",
                onSelectRecipe: { recipe in
                    plannerStore.assign(recipe: recipe, to: slot.dayKey, meal: slot.meal)
                    activeSlot = nil
                }
            )
        }
        .onAppear {
            seedInitialSelectionIfNeeded()
        }
    }

    private var weekDates: [Date] {
        weekDates(for: plannerStore.selectedDate)
    }

    private var currentWeekDayKeys: [DayKey] {
        weekDates.map { DayKey($0, calendar: calendar) }
    }

    private var orderedSelectedDayKeys: [DayKey] {
        selectedDayKeys.sorted { $0.date < $1.date }
    }

    private var topSelectorDayKeys: [DayKey] {
        orderedSelectedDayKeys.isEmpty ? currentWeekDayKeys : orderedSelectedDayKeys
    }

    private var plannerDayKeys: [DayKey] {
        orderedSelectedDayKeys
    }

    private var plannedDayKeys: Set<DayKey> {
        Set(plannerStore.assignments.keys)
    }

    private func weekDates(for anchorDate: Date) -> [Date] {
        let anchor = calendar.startOfDay(for: anchorDate)
        let weekday = calendar.component(.weekday, from: anchor)
        let daysFromMonday = (weekday + 5) % 7

        guard let start = calendar.date(byAdding: .day, value: -daysFromMonday, to: anchor) else {
            return [anchorDate]
        }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    private func shiftWeek(by weeks: Int) {
        let previousWeek = Set(currentWeekDayKeys)

        if let newDate = calendar.date(byAdding: .day, value: weeks * 7, to: plannerStore.selectedDate) {
            plannerStore.selectedDate = newDate

            if selectedDayKeys.isEmpty || selectedDayKeys == previousWeek {
                selectedDayKeys = Set(weekDates(for: newDate).map { DayKey($0, calendar: calendar) })
            }
        }
    }

    private func shiftMonth(by months: Int) {
        if let newDate = calendar.date(byAdding: .month, value: months, to: plannerStore.selectedDate) {
            plannerStore.selectedDate = newDate
        }
    }

    private func handleTopSelectorPrimaryTap(_ dayKey: DayKey) {
        plannerStore.selectedDate = dayKey.date
        focusedDayKey = dayKey
    }

    private func toggleDayFromPlannerRow(_ dayKey: DayKey) {
        plannerStore.selectedDate = dayKey.date
        toggleDiscreteDay(dayKey)
    }

    private func toggleDiscreteDay(_ dayKey: DayKey) {
        if selectedDayKeys.contains(dayKey) {
            selectedDayKeys.remove(dayKey)
            updateAnchorAfterRemoval(fallback: dayKey.date)
        } else {
            selectedDayKeys.insert(dayKey)
            focusedDayKey = dayKey
        }
    }

    private func removeSelectedDay(_ dayKey: DayKey) {
        guard selectedDayKeys.contains(dayKey) else { return }
        selectedDayKeys.remove(dayKey)
        if focusedDayKey == dayKey {
            focusedDayKey = orderedSelectedDayKeys.first(where: { $0 != dayKey })
        }
        updateAnchorAfterRemoval(fallback: dayKey.date)
    }

    private func handleCalendarTap(_ date: Date) {
        let dayKey = DayKey(date, calendar: calendar)
        plannerStore.selectedDate = date
        selectedDayKeys = [dayKey]
        focusedDayKey = dayKey
    }

    private func handleCalendarRangeDrag(from startDate: Date, to endDate: Date) {
        let startKey = DayKey(startDate, calendar: calendar)
        let endKey = DayKey(endDate, calendar: calendar)
        let rangeKeys = dayKeys(in: startKey, and: endKey)
        selectedDayKeys = Set(rangeKeys)
        plannerStore.selectedDate = endKey.date
        focusedDayKey = endKey
    }

    private func handleVisibleMonthChange(_ date: Date) {
        plannerStore.selectedDate = date
    }

    private func dayKeys(in first: DayKey, and second: DayKey) -> [DayKey] {
        let start = min(first.date, second.date)
        let end = max(first.date, second.date)
        let dayCount = calendar.dateComponents([.day], from: start, to: end).day ?? 0

        return (0...dayCount).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: start).map { DayKey($0, calendar: calendar) }
        }
    }

    private func updateAnchorAfterRemoval(fallback: Date) {
        if let firstRemainingDay = orderedSelectedDayKeys.first?.date {
            plannerStore.selectedDate = firstRemainingDay
        } else {
            plannerStore.selectedDate = fallback
            focusedDayKey = nil
        }
    }

    private func seedInitialSelectionIfNeeded() {
        guard selectedDayKeys.isEmpty else { return }
        selectedDayKeys = Set(currentWeekDayKeys)
        focusedDayKey = orderedSelectedDayKeys.first
    }

    private func focusRow(for dayKey: DayKey, proxy: ScrollViewProxy) {
        plannerStore.selectedDate = dayKey.date
        focusedDayKey = dayKey
        withAnimation(.easeInOut(duration: 0.24)) {
            proxy.scrollTo(dayKey, anchor: .center)
        }
    }
}

private struct PlannerMonthCalendarView: View {
    let visibleMonthDate: Date
    let selectedDayKeys: Set<DayKey>
    let plannedDayKeys: Set<DayKey>
    let calendar: Calendar
    let onTapDate: (Date) -> Void
    let onDragRange: (Date, Date) -> Void
    let onVisibleMonthChange: (Date) -> Void
    @State private var dragStartDate: Date?
    @State private var dragCurrentDate: Date?

    private let weekdaySymbols = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        let monthDates = monthGridDates

        VStack(spacing: DesignSystem.Spacing.sm) {
            HStack(spacing: 0) {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(maxWidth: .infinity)
                }
            }

            GeometryReader { geometry in
                let cellWidth = geometry.size.width / 7
                let cellHeight = PlannerLayout.calendarCellHeight

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 0) {
                    ForEach(monthDates, id: \.self) { date in
                        calendarCell(for: date)
                            .frame(height: cellHeight)
                    }
                }
                .contentShape(Rectangle())
                .coordinateSpace(name: "plannerMonthGrid")
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .named("plannerMonthGrid"))
                        .onChanged { value in
                            guard let date = date(at: value.location, cellWidth: cellWidth, cellHeight: cellHeight, dates: monthDates) else {
                                return
                            }

                            if dragStartDate == nil {
                                dragStartDate = date
                                dragCurrentDate = date
                            } else if dragCurrentDate != date {
                                dragCurrentDate = date
                                if let start = dragStartDate {
                                    onDragRange(start, date)
                                }
                            }
                        }
                        .onEnded { value in
                            guard let start = dragStartDate,
                                  let end = date(at: value.location, cellWidth: cellWidth, cellHeight: cellHeight, dates: monthDates) else {
                                dragStartDate = nil
                                dragCurrentDate = nil
                                return
                            }

                            if calendar.isDate(start, inSameDayAs: end) {
                                onTapDate(end)
                            } else {
                                onDragRange(start, end)
                            }

                            dragStartDate = nil
                            dragCurrentDate = nil
                        }
                )
            }
            .frame(height: calendarGridHeight)
        }
        .onAppear {
            onVisibleMonthChange(monthStartDate)
        }
        .onChange(of: monthStartDate) { _, newValue in
            onVisibleMonthChange(newValue)
        }
    }

    private var monthStartDate: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: visibleMonthDate)) ?? visibleMonthDate
    }

    private var monthGridDates: [Date] {
        let monthStartWeekday = calendar.component(.weekday, from: monthStartDate)
        let leadingOffset = (monthStartWeekday + 5) % 7
        let gridStart = calendar.date(byAdding: .day, value: -leadingOffset, to: monthStartDate) ?? monthStartDate

        return (0..<42).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: gridStart)
        }
    }

    private var visibleWeekCount: Int {
        let weeks = stride(from: 0, to: monthGridDates.count, by: 7).map { start in
            Array(monthGridDates[start..<min(start + 7, monthGridDates.count)])
        }

        let lastWeekIndex = weeks.lastIndex { week in
            week.contains { calendar.isDate($0, equalTo: monthStartDate, toGranularity: .month) }
        } ?? 0

        return lastWeekIndex + 1
    }

    private var calendarGridHeight: CGFloat {
        PlannerLayout.calendarCellHeight * CGFloat(visibleWeekCount)
    }

    private func calendarCell(for date: Date) -> some View {
        let dayKey = DayKey(date, calendar: calendar)
        let isSelected = selectedDayKeys.contains(dayKey)
        let isPlanned = plannedDayKeys.contains(dayKey)
        let isCurrentMonth = calendar.isDate(date, equalTo: monthStartDate, toGranularity: .month)

        return VStack(spacing: 4) {
            if isCurrentMonth {
                Text("\(calendar.component(.day, from: date))")
                    .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? DesignSystem.Colors.backgroundNearBlack : DesignSystem.Colors.textCream)
                    .frame(width: 30, height: 30)
                    .background(
                        Circle()
                            .fill(isSelected ? DesignSystem.Colors.textCream : Color.clear)
                    )

                Circle()
                    .fill(isPlanned ? DesignSystem.Colors.ctaGreen : Color.clear)
                    .frame(width: 8, height: 8)
            } else {
                Color.clear
                    .frame(width: 30, height: 30)
                Color.clear
                    .frame(width: 8, height: 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.clear)
        )
    }

    private func date(at location: CGPoint, cellWidth: CGFloat, cellHeight: CGFloat, dates: [Date]) -> Date? {
        guard cellWidth > 0, cellHeight > 0 else { return nil }
        let column = min(6, max(0, Int(location.x / cellWidth)))
        let row = min(5, max(0, Int(location.y / cellHeight)))
        let index = row * 7 + column
        guard dates.indices.contains(index) else { return nil }
        let date = dates[index]
        guard calendar.isDate(date, equalTo: monthStartDate, toGranularity: .month) else {
            return nil
        }
        return date
    }
}

private enum PlannerLayout {
    static let dayColumnWidth: CGFloat = 66
    static let mealColumnWidth: CGFloat = 62
    static let mealBubbleSize: CGFloat = 40
    static let topSelectorWidth: CGFloat = 68
    static let calendarCellHeight: CGFloat = 44
    static let calendarHeaderHeight: CGFloat = 24
    static let rowBackgrounds: [Color] = [
        DesignSystem.Colors.plannerRowMonday,
        DesignSystem.Colors.plannerRowTuesday,
        DesignSystem.Colors.plannerRowWednesday,
        DesignSystem.Colors.plannerRowThursday,
        DesignSystem.Colors.plannerRowFriday,
        DesignSystem.Colors.plannerRowSaturday,
        DesignSystem.Colors.plannerRowSunday
    ]
}

private struct MealSlot: Identifiable, Hashable {
    let dayKey: DayKey
    let meal: PlannerMeal

    var id: String {
        "\(dayKey.date.timeIntervalSince1970)-\(meal.rawValue)"
    }

    var title: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return "\(formatter.string(from: dayKey.date)) \(meal.title)"
    }

    static func == (lhs: MealSlot, rhs: MealSlot) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

private struct WeekHeaderView: View {
    @Binding var selectedDate: Date
    let visibleDayKeys: [DayKey]
    let selectedDayKeys: Set<DayKey>
    let focusedDayKey: DayKey?
    let calendar: Calendar
    @Binding var isCalendarExpanded: Bool
    let onPrimaryTapDay: (DayKey) -> Void
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

                Button(action: { withAnimation(.easeInOut(duration: 0.2)) { isCalendarExpanded.toggle() } }) {
                    HStack(spacing: 6) {
                        Text(monthFormatter.string(from: selectedDate))
                            .font(DesignSystem.Fonts.screenTitle)
                            .foregroundColor(DesignSystem.Colors.textCream)
                        Image(systemName: isCalendarExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    }
                }
                .buttonStyle(.plain)

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
                HStack(spacing: DesignSystem.Spacing.xs) {
                    ForEach(visibleDayKeys, id: \.self) { dayKey in
                        let isSelected = selectedDayKeys.contains(dayKey)
                        let isFocused = focusedDayKey == dayKey
                        VStack(spacing: 4) {
                            Text(weekdayFormatter.string(from: dayKey.date))
                                .font(DesignSystem.Fonts.valueProp)
                            Text("\(calendar.component(.day, from: dayKey.date))")
                                .font(DesignSystem.Fonts.subtitle)
                        }
                        .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                        .frame(width: PlannerLayout.topSelectorWidth)
                        .padding(.vertical, 8)
                        .background(DesignSystem.Colors.textCream)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(
                                    isSelected
                                    ? DesignSystem.Colors.backgroundNearBlack.opacity(isFocused ? 0.7 : 0.35)
                                    : (isFocused ? DesignSystem.Colors.backgroundNearBlack.opacity(0.5) : Color.clear),
                                    lineWidth: 1.5
                                )
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .onTapGesture {
                            onPrimaryTapDay(dayKey)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

private struct DayPlanRowView: View {
    let date: Date
    let dayIndex: Int
    let rowHeight: CGFloat
    let isSelected: Bool
    let isFocused: Bool
    let meals: [PlannerMeal: RecipeRef]
    let onSelectDay: () -> Void
    let onSelectMeal: (PlannerMeal) -> Void
    let onRemoveMeal: (PlannerMeal) -> Void
    let onRemoveDay: () -> Void

    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    var body: some View {
        Button(action: onSelectDay) {
            HStack(alignment: .center, spacing: DesignSystem.Spacing.sm) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(weekdayFormatter.string(from: date))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(DesignSystem.Colors.textCream)
                            .lineLimit(1)

                        Text("\(Calendar.current.component(.day, from: date))")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(DesignSystem.Colors.textCream)
                            .lineLimit(1)
                    }

                    Text("Cal \(totalCalories)")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(DesignSystem.Colors.plannerCaloriesRed)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                }
                .frame(width: PlannerLayout.dayColumnWidth, alignment: .leading)

                HStack(spacing: DesignSystem.Spacing.xs) {
                    ForEach(PlannerMeal.allCases, id: \.self) { meal in
                        MealColumnView(
                            meal: meal,
                            recipe: meals[meal],
                            onSelect: { onSelectMeal(meal) },
                            onRemove: { onRemoveMeal(meal) }
                        )
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, minHeight: rowHeight, maxHeight: rowHeight)
            .background(rowBackground)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(
                        isSelected
                        ? DesignSystem.Colors.textCream.opacity(isFocused ? 0.42 : 0.24)
                        : DesignSystem.Colors.divider,
                        lineWidth: isSelected ? 1.5 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onRemoveDay) {
                Text("Remove")
            }
        }
    }

    private var totalCalories: Int {
        meals.values.compactMap(\.calories).reduce(0, +)
    }

    private var rowBackground: Color {
        let base = PlannerLayout.rowBackgrounds[min(dayIndex, PlannerLayout.rowBackgrounds.count - 1)]
        if isSelected {
            return DesignSystem.Colors.card.opacity(isFocused ? 0.94 : 0.86)
        }
        return base
    }
}

private struct MealColumnView: View {
    let meal: PlannerMeal
    let recipe: RecipeRef?
    let onSelect: () -> Void
    let onRemove: () -> Void

    var body: some View {
        Button(action: onSelect) {
            if let recipe = recipe {
                MealThumbnailView(recipe: recipe, size: PlannerLayout.mealBubbleSize)
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
            Color.clear
                .frame(width: PlannerLayout.dayColumnWidth + 6)

            ForEach(PlannerMeal.allCases, id: \.self) { meal in
                Text(meal.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .frame(width: PlannerLayout.mealColumnWidth, alignment: .center)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 4)
        .padding(.leading, 6)
        .padding(.bottom, 2)
    }
}

private struct MealThumbnailView: View {
    let recipe: RecipeRef
    let size: CGFloat

    init(recipe: RecipeRef, size: CGFloat = 36) {
        self.recipe = recipe
        self.size = size
    }

    var body: some View {
        VStack(spacing: 4) {
            HeroImageView(imageName: recipe.imageName ?? "")
                .frame(width: size, height: size)
                .clipShape(Circle())

            if let calories = recipe.calories {
                Text("\(calories)")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 1)
                    .background(DesignSystem.Colors.card.opacity(0.9))
                    .clipShape(Capsule())
            }
        }
    }

}

private struct PlannerAddDishFlow: View {
    let slot: MealSlot
    let recipes: [Recipe]
    let onCancel: () -> Void
    let onConfirm: (Recipe) -> Void

    @State private var step: AddDishStep = .preferences
    @State private var selectedPreferences: Set<String> = []
    @State private var selectedRecipe: Recipe?
    @State private var searchQuery = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                Text(step.title)
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                switch step {
                case .preferences:
                    preferenceSelection
                case .recipes:
                    recipeSelection
                case .confirm:
                    confirmSelection
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, DesignSystem.Spacing.md)
            .padding(.bottom, DesignSystem.Spacing.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(DesignSystem.Colors.backgroundNearBlack)
            .navigationTitle("Add Dish")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        onCancel()
                    }
                    .foregroundColor(DesignSystem.Colors.textCream)
                }
            }
        }
    }

    private var preferenceSelection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text("Select your preferences")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textMuted)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: DesignSystem.Spacing.sm) {
                ForEach(preferenceOptions, id: \.title) { option in
                    Chip(
                        title: option.title,
                        systemIcon: option.systemImage,
                        tint: .green,
                        isSelected: selectedPreferences.contains(option.title)
                    ) {
                        if selectedPreferences.contains(option.title) {
                            selectedPreferences.remove(option.title)
                        } else {
                            selectedPreferences.insert(option.title)
                        }
                    }
                }
            }

            Button(action: { step = .recipes }) {
                Text("Continue to recipes")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(DesignSystem.Colors.ctaGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
        }
    }

    private var recipeSelection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            SearchBar(text: $searchQuery, placeholder: "Search recipes")

            ScrollView {
                LazyVStack(spacing: DesignSystem.Spacing.sm) {
                    ForEach(filteredRecipes) { recipe in
                        Button(action: {
                            selectedRecipe = recipe
                            step = .confirm
                        }) {
                            HStack(spacing: DesignSystem.Spacing.sm) {
                                PlannerRecipeThumb(recipe: recipe)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(recipe.title)
                                        .font(DesignSystem.Fonts.subtitle)
                                        .foregroundColor(DesignSystem.Colors.textCream)

                                    Text(recipe.subtitle)
                                        .font(DesignSystem.Fonts.valueProp)
                                        .foregroundColor(DesignSystem.Colors.textMuted)
                                }

                                Spacer()
                            }
                            .padding(.horizontal, DesignSystem.Spacing.md)
                            .padding(.vertical, 10)
                            .background(DesignSystem.Colors.card)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            Button(action: { step = .preferences }) {
                Text("Back")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
            .buttonStyle(.plain)
        }
    }

    private var confirmSelection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            if let selectedRecipe {
                HStack(spacing: DesignSystem.Spacing.sm) {
                    PlannerRecipeThumb(recipe: selectedRecipe)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(selectedRecipe.title)
                            .font(DesignSystem.Fonts.subtitle)
                            .foregroundColor(DesignSystem.Colors.textCream)
                        Text(selectedRecipe.subtitle)
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    }
                }
                .padding(DesignSystem.Spacing.md)
                .background(DesignSystem.Colors.card)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                Button(action: { onConfirm(selectedRecipe) }) {
                    Text("Add to \(slot.title)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(DesignSystem.Colors.ctaGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
            }

            Button(action: { step = .recipes }) {
                Text("Back")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
            .buttonStyle(.plain)
        }
    }

    private var filteredRecipes: [Recipe] {
        let base = recipes.filter { recipe in
            selectedPreferences.isEmpty || selectedPreferences.contains(where: { matches(recipe: recipe, preference: $0) })
        }

        let trimmed = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !trimmed.isEmpty else { return base }
        return base.filter { $0.title.lowercased().contains(trimmed) }
    }

    private func matches(recipe: Recipe, preference: String) -> Bool {
        let haystack = "\(recipe.title) \(recipe.category)".lowercased()
        let keywords: [String: [String]] = [
            "Carnivore": ["meat", "chicken", "beef", "pork", "steak", "turkey", "lamb"],
            "Vegetarian": ["vegetarian", "veggie", "mushroom", "tofu", "plant"],
            "Seafood": ["seafood", "fish", "salmon", "shrimp", "cod", "tuna", "scallop"],
            "World": ["mediterranean", "shawarma", "curry", "fajita", "gnocchi", "teriyaki"],
            "Fit": ["protein", "healthy", "low carb", "under 500"],
            "Desserts": ["dessert", "brioche", "rolls", "pudding", "pancake"],
            "Budget": ["meal prep", "batch", "quick dinner"],
            "Quick & Easy": ["quick", "15 min", "easy", "tips"],
            "Spicy": ["spicy", "chili", "heat"],
            "Gluten-free": ["low carb", "vegan", "vegetarian"]
        ]
        return keywords[preference, default: []].contains { haystack.contains($0) }
    }
}

private enum AddDishStep {
    case preferences
    case recipes
    case confirm

    var title: String {
        switch self {
        case .preferences:
            return "Step 1: Preferences"
        case .recipes:
            return "Step 2: Pick a Recipe"
        case .confirm:
            return "Step 3: Confirm"
        }
    }
}

private struct PlannerPreferenceOption {
    let title: String
    let systemImage: String
}

private let preferenceOptions: [PlannerPreferenceOption] = [
    PlannerPreferenceOption(title: "Carnivore", systemImage: "flame.fill"),
    PlannerPreferenceOption(title: "Vegetarian", systemImage: "leaf.fill"),
    PlannerPreferenceOption(title: "Seafood", systemImage: "fish"),
    PlannerPreferenceOption(title: "World", systemImage: "globe.europe.africa.fill"),
    PlannerPreferenceOption(title: "Fit", systemImage: "figure.run"),
    PlannerPreferenceOption(title: "Desserts", systemImage: "cup.and.saucer.fill"),
    PlannerPreferenceOption(title: "Budget", systemImage: "dollarsign.circle.fill"),
    PlannerPreferenceOption(title: "Quick & Easy", systemImage: "bolt.fill"),
    PlannerPreferenceOption(title: "Spicy", systemImage: "flame"),
    PlannerPreferenceOption(title: "Gluten-free", systemImage: "leaf.arrow.circlepath")
]

private struct PlannerRecipeThumb: View {
    let recipe: Recipe

    var body: some View {
        HeroImageView(imageName: recipe.heroImageName)
        .frame(width: 44, height: 44)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview("Light Mode") {
    PlannerView()
        .environmentObject(PlannerStore())
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}

#Preview("Dark Mode") {
    PlannerView()
        .environmentObject(PlannerStore())
        .environmentObject(ThemeManager(theme: .dark))
        .environment(\.colorScheme, .dark)
}
