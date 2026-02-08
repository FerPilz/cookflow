//
//  HomeSectionView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct HomeSectionView: View {
    let title: String
    let recipes: [Recipe]
    let favoriteIDs: Set<UUID>
    let onToggleFavorite: (Recipe) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignSystem.Spacing.sm) {
                    ForEach(recipes) { recipe in
                        RecipeCardView(
                            recipe: recipe,
                            width: 200,
                            height: 150,
                            isFavorite: favoriteIDs.contains(recipe.id),
                            onToggleFavorite: { onToggleFavorite(recipe) }
                        )
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }
}

#Preview {
    HomeSectionView(
        title: "Top Picks for You",
        recipes: SampleData.recipes(for: "Top Picks for You"),
        favoriteIDs: [],
        onToggleFavorite: { _ in }
    )
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
