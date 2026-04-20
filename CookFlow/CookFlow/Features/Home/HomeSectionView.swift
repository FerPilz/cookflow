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
    let favoriteIDs: Set<String>
    let onToggleFavorite: (Recipe) -> Void
    let onSelectRecipe: (Recipe) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack(spacing: DesignSystem.Spacing.xs) {
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textCream)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
            .padding(.top, DesignSystem.Spacing.xs)
            .padding(.bottom, 4)

            GeometryReader { geo in
                let cardWidth = max(228, geo.size.width * 0.84)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: DesignSystem.Spacing.sm) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(
                                    recipe: recipe,
                                    width: cardWidth,
                                    height: 208,
                                    isFavorite: favoriteIDs.contains(recipe.id),
                                    onToggleFavorite: { onToggleFavorite(recipe) }
                                )
                            }
                            .frame(width: cardWidth, alignment: .leading)
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                            .simultaneousGesture(TapGesture().onEnded {
                                onSelectRecipe(recipe)
                            })
                        }
                    }
                    .padding(.leading, 0)
                    .padding(.trailing, DesignSystem.Spacing.xl)
                }
            }
            .frame(height: 282)
        }
        .padding(.bottom, DesignSystem.Spacing.sm)
    }
}

#Preview {
    HomeSectionView(
        title: "Top Picks for You",
        recipes: SampleData.recipes(for: "Top Picks for You"),
        favoriteIDs: [],
        onToggleFavorite: { _ in },
        onSelectRecipe: { _ in }
    )
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
