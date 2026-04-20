//
//  RecipeMetadataRow.swift
//  CookFlow
//
//  Created by Codex on 3/24/26.
//

import SwiftUI

struct RecipeMetadataRow: View {
    let recipe: Recipe
    var iconColor: Color = DesignSystem.Colors.ctaGreen
    var textColor: Color = DesignSystem.Colors.textMuted
    var includeCalories: Bool = true

    var body: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            metadataItem(systemName: "clock", value: timeText)

            if includeCalories, let caloriesText {
                metadataItem(systemName: "flame.fill", value: caloriesText)
            }

            metadataItem(systemName: "person.2.fill", value: servingsText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private func metadataItem(systemName: String, value: String?) -> some View {
        if let value {
            HStack(spacing: 5) {
                Image(systemName: systemName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(iconColor)

                Text(value)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(textColor)
                    .lineLimit(1)
            }
        }
    }

    private var timeText: String? {
        if let duration = recipe.durationMinutes {
            return "\(duration) min"
        }

        if let prepMinutes = recipe.prepMinutes {
            return "\(prepMinutes) min"
        }

        return nil
    }

    private var caloriesText: String? {
        guard let calories = recipe.calories else { return nil }
        return "\(calories) cal"
    }

    private var servingsText: String? {
        let trimmed = recipe.quantityText.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}

#Preview {
    RecipeMetadataRow(recipe: SampleData.allRecipes.first ?? Recipe(title: "Sample", subtitle: "Recipe"))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
