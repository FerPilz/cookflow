//
//  PreferencesView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var selectedPreferences: [String]
    @Binding var optimizationGoal: String
    @Binding var hasSelection: Bool
    @Binding var stepIndex: Int
    @State private var selectedFoodStyles: Set<FoodStylePreference>
    @State private var selectedGoals: Set<GoalPreference>
    @State private var selectedOptimizationPreferences: Set<OptimizationPreference>
    @State private var selectedCuisinePreferences: Set<String>
    @State private var selectedCookingFrequency: Set<String>
    @State private var selectedRecipeUsage: Set<String>
    private let optionHeight: CGFloat = 44
    private let totalSteps = 5

    init(
        selectedPreferences: Binding<[String]>,
        optimizationGoal: Binding<String>,
        hasSelection: Binding<Bool>,
        stepIndex: Binding<Int>
    ) {
        _selectedPreferences = selectedPreferences
        _optimizationGoal = optimizationGoal
        _hasSelection = hasSelection
        _stepIndex = stepIndex

        var initialFoodStyles = Set<FoodStylePreference>()
        var initialGoals = Set<GoalPreference>()
        var initialOptimizations = Set<OptimizationPreference>()
        var initialCuisine = Set<String>()
        var initialCookingFrequency = Set<String>()
        var initialRecipeUsage = Set<String>()

        for value in selectedPreferences.wrappedValue {
            if let item = FoodStylePreference(rawValue: value) {
                initialFoodStyles.insert(item)
            }
            if let item = GoalPreference(rawValue: value) {
                initialGoals.insert(item)
            }
            if let item = OptimizationPreference(rawValue: value) {
                initialOptimizations.insert(item)
            }
            if Self.cuisineOptions.contains(value) {
                initialCuisine.insert(value)
            }
            if Self.cookingFrequencyOptions.contains(value) {
                initialCookingFrequency.insert(value)
            }
            if Self.recipeUsageOptions.contains(value) {
                initialRecipeUsage.insert(value)
            }
        }

        _selectedFoodStyles = State(initialValue: initialFoodStyles)
        _selectedGoals = State(initialValue: initialGoals)
        _selectedOptimizationPreferences = State(initialValue: initialOptimizations)
        _selectedCuisinePreferences = State(initialValue: initialCuisine)
        _selectedCookingFrequency = State(initialValue: initialCookingFrequency)
        _selectedRecipeUsage = State(initialValue: initialRecipeUsage)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: DesignSystem.Spacing.md) {
                Text("Step \(stepIndex + 1) of \(totalSteps)")
                    .font(DesignSystem.Fonts.stepLabel)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .frame(maxWidth: .infinity, alignment: .center)

                stepContent
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, 0)
            .padding(.bottom, DesignSystem.Spacing.md)
        }
        .onAppear {
            syncBindings()
            updateSelectionState()
        }
        .onChange(of: stepIndex) { _, _ in
            updateSelectionState()
        }
        .onChange(of: selectedFoodStyles) { _, _ in updateSelectionState() }
        .onChange(of: selectedGoals) { _, _ in updateSelectionState() }
        .onChange(of: selectedOptimizationPreferences) { _, _ in updateSelectionState() }
        .onChange(of: selectedCuisinePreferences) { _, _ in updateSelectionState() }
        .onChange(of: selectedCookingFrequency) { _, _ in updateSelectionState() }
        .onChange(of: selectedRecipeUsage) { _, _ in updateSelectionState() }
    }

    @ViewBuilder
    private var stepContent: some View {
        switch stepIndex {
        case 0:
            foodStyleStep
        case 1:
            goalsStep
        case 2:
            cuisineStep
        case 3:
            optimizationStep
        default:
            cookingFrequencyStep
        }
    }

    private var foodStyleStep: some View {
        PreferenceSectionView(
            title: "Food Style Preferences",
            subtitle: "Select all that apply"
        ) {
            LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.md) {
                ForEach(FoodStylePreference.allCases) { option in
                    PreferenceTileView(
                        title: option.rawValue,
                        isSelected: selectedFoodStyles.contains(option),
                        fixedHeight: optionHeight
                    ) {
                        toggleFoodStyle(option)
                        syncBindings()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var goalsStep: some View {
        PreferenceSectionView(
            title: "Goals",
            subtitle: "Pick outcomes you want to prioritize"
        ) {
            LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.md) {
                ForEach(goalOptions) { option in
                    PreferenceTileView(
                        title: option.rawValue,
                        isSelected: selectedGoals.contains(option),
                        fixedHeight: optionHeight
                    ) {
                        toggleGoal(option)
                        syncBindings()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var cuisineStep: some View {
        PreferenceSectionView(
            title: "Cuisine Preference",
            subtitle: "Pick cuisines you enjoy"
        ) {
            LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.sm) {
                ForEach(cuisineOptions, id: \.self) { option in
                    PreferenceTileView(
                        title: option,
                        isSelected: selectedCuisinePreferences.contains(option),
                        fixedHeight: optionHeight
                    ) {
                        toggleStringOption(option, in: &selectedCuisinePreferences)
                        syncBindings()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var optimizationStep: some View {
        PreferenceSectionView(
            title: "Optimization Preferences",
            subtitle: "Select what matters most"
        ) {
            LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.sm) {
                ForEach(OptimizationPreference.allCases) { option in
                    PreferenceTileView(
                        title: option.rawValue,
                        isSelected: selectedOptimizationPreferences.contains(option),
                        fixedHeight: optionHeight
                    ) {
                        toggleOptimization(option)
                        syncBindings()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var cookingFrequencyStep: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            PreferenceSectionView(
                title: "How many times do you cook?",
                subtitle: "Per week"
            ) {
                LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.sm) {
                    ForEach(cookingFrequencyOptions, id: \.self) { option in
                        PreferenceTileView(
                            title: option,
                            isSelected: selectedCookingFrequency.contains(option),
                            fixedHeight: optionHeight
                        ) {
                            toggleStringOption(option, in: &selectedCookingFrequency)
                            syncBindings()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }

            PreferenceSectionView(
                title: "How often do you use recipes?",
                subtitle: "Select all that apply"
            ) {
                LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.sm) {
                    ForEach(recipeUsageOptions, id: \.self) { option in
                        PreferenceTileView(
                            title: option,
                            isSelected: selectedRecipeUsage.contains(option),
                            fixedHeight: optionHeight
                        ) {
                            toggleStringOption(option, in: &selectedRecipeUsage)
                            syncBindings()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var gridColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: DesignSystem.Spacing.md),
            GridItem(.flexible(), spacing: DesignSystem.Spacing.md)
        ]
    }

    private func toggleFoodStyle(_ option: FoodStylePreference) {
        if selectedFoodStyles.contains(option) {
            selectedFoodStyles.remove(option)
        } else {
            selectedFoodStyles.insert(option)
        }
        syncBindings()
    }

    private func toggleGoal(_ option: GoalPreference) {
        if selectedGoals.contains(option) {
            selectedGoals.remove(option)
        } else {
            selectedGoals.insert(option)
        }
        syncBindings()
    }

    private func toggleOptimization(_ option: OptimizationPreference) {
        if selectedOptimizationPreferences.contains(option) {
            selectedOptimizationPreferences.remove(option)
        } else {
            selectedOptimizationPreferences.insert(option)
        }
        syncBindings()
    }

    private var goalOptions: [GoalPreference] {
        [
            .weightLoss,
            .muscleGain,
            .maintain,
            .heartHealth,
            .energy,
            .betterSleep
        ]
    }

    private static let cuisineOptions: [String] = [
        "Mexican",
        "American",
        "Indian",
        "Chinese",
        "Italian",
        "Mediterranean",
        "German",
        "Middle Eastern",
        "Japanese",
        "Vietnamese"
    ]

    private static let cookingFrequencyOptions: [String] = [
        "Daily",
        "Few times",
        "Weekends",
        "Never"
    ]

    private static let recipeUsageOptions: [String] = [
        "Daily",
        "Weekly",
        "Weekends",
        "Few times"
    ]

    private var cuisineOptions: [String] {
        Self.cuisineOptions
    }

    private var cookingFrequencyOptions: [String] {
        Self.cookingFrequencyOptions
    }

    private var recipeUsageOptions: [String] {
        Self.recipeUsageOptions
    }

    private func toggleStringOption(_ option: String, in set: inout Set<String>) {
        if set.contains(option) {
            set.remove(option)
        } else {
            set.insert(option)
        }
    }

    private func syncBindings() {
        let orderedFoodStyles = FoodStylePreference.allCases.filter { selectedFoodStyles.contains($0) }
        let orderedGoals = goalOptions.filter { selectedGoals.contains($0) }
        let orderedOptimizations = OptimizationPreference.allCases.filter { selectedOptimizationPreferences.contains($0) }
        selectedPreferences =
            orderedFoodStyles.map(\.rawValue) +
            orderedGoals.map(\.rawValue) +
            orderedOptimizations.map(\.rawValue) +
            cuisineOptions.filter { selectedCuisinePreferences.contains($0) } +
            cookingFrequencyOptions.filter { selectedCookingFrequency.contains($0) } +
            recipeUsageOptions.filter { selectedRecipeUsage.contains($0) }
        optimizationGoal = orderedGoals.first?.rawValue ?? ""
        updateSelectionState()
    }

    private func updateSelectionState() {
        switch stepIndex {
        case 0:
            hasSelection = !selectedFoodStyles.isEmpty
        case 1:
            hasSelection = !selectedGoals.isEmpty
        case 2:
            hasSelection = !selectedCuisinePreferences.isEmpty
        case 3:
            hasSelection = !selectedOptimizationPreferences.isEmpty
        default:
            hasSelection = !selectedCookingFrequency.isEmpty || !selectedRecipeUsage.isEmpty
        }
    }
}

#Preview {
    PreferencesView(
        selectedPreferences: .constant([]),
        optimizationGoal: .constant(""),
        hasSelection: .constant(false),
        stepIndex: .constant(0)
    )
        .preferredColorScheme(.dark)
}
