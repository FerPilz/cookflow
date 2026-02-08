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

    var body: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.lg) {
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Text("What do you like?")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .multilineTextAlignment(.center)

                    Text("Pick all that apply.")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.sm) {
                    ForEach(preferenceOptions, id: \.title) { option in
                        Chip(
                            title: option.title,
                            systemIcon: option.systemIcon,
                            tint: option.tint,
                            isSelected: selectedPreferences.contains(option.title)
                        ) {
                            togglePreference(option.title)
                        }
                    }
                }

                VStack(spacing: DesignSystem.Spacing.sm) {
                    Text("What are you optimizing for?")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    LazyVGrid(columns: optimizationColumns, spacing: DesignSystem.Spacing.sm) {
                        optimizationChip(title: "Protein", icon: "dumbbell", tint: .orange)
                        optimizationChip(title: "Prep time", icon: "clock", tint: .blue)
                        optimizationChip(title: "Price", icon: "tag.fill", tint: .green)
                    }
                }
                .padding(DesignSystem.Spacing.md)
                .background(DesignSystem.Colors.card)
                .cornerRadius(DesignSystem.Radius.standard)
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.vertical, DesignSystem.Spacing.sm)
        }
    }

    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: DesignSystem.Spacing.sm), count: 2)
    }

    private var preferenceOptions: [PreferenceOption] {
        [
            PreferenceOption(title: "Carnivore", systemIcon: "flame.fill", tint: .red),
            PreferenceOption(title: "Vegetarian", systemIcon: "leaf.fill", tint: .green),
            PreferenceOption(title: "Seafood", systemIcon: "fish", tint: .blue),
            PreferenceOption(title: "World", systemIcon: "globe.europe.africa.fill", tint: .cyan),
            PreferenceOption(title: "Fit", systemIcon: "figure.run", tint: .mint),
            PreferenceOption(title: "Desserts", systemIcon: "cup.and.saucer.fill", tint: .pink),
            PreferenceOption(title: "Budget", systemIcon: "dollarsign.circle.fill", tint: .green),
            PreferenceOption(title: "Quick & Easy", systemIcon: "bolt.fill", tint: .yellow),
            PreferenceOption(title: "Spicy", systemIcon: "flame", tint: .orange),
            PreferenceOption(title: "Gluten-free", systemIcon: "leaf.arrow.circlepath", tint: .teal)
        ]
    }

    private var optimizationColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: DesignSystem.Spacing.sm), count: 3)
    }

    private func togglePreference(_ title: String) {
        if let index = selectedPreferences.firstIndex(of: title) {
            selectedPreferences.remove(at: index)
        } else {
            selectedPreferences.append(title)
        }
    }

    @ViewBuilder
    private func optimizationChip(title: String, icon: String, tint: Color) -> some View {
        Chip(
            title: title,
            systemIcon: icon,
            tint: tint,
            isSelected: optimizationGoal == title
        ) {
            optimizationGoal = optimizationGoal == title ? "" : title
        }
    }
}

#Preview {
    PreferencesView(selectedPreferences: .constant([]), optimizationGoal: .constant(""))
        .preferredColorScheme(.dark)
}

private struct PreferenceOption {
    let title: String
    let systemIcon: String
    let tint: Color
}
