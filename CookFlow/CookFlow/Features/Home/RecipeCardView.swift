//
//  RecipeCardView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let width: CGFloat?
    let height: CGFloat
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    init(
        recipe: Recipe,
        width: CGFloat? = 200,
        height: CGFloat = 160,
        isFavorite: Bool = false,
        onToggleFavorite: @escaping () -> Void = {}
    ) {
        self.recipe = recipe
        self.width = width
        self.height = height
        self.isFavorite = isFavorite
        self.onToggleFavorite = onToggleFavorite
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            ZStack(alignment: .topTrailing) {
                imageLayer
                    .frame(width: cardWidth, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous))

                Button(action: onToggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.35))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(10)
            }

            Text(recipe.title)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .lineLimit(2)

            RecipeMetadataRow(recipe: recipe)
        }
        .frame(width: cardWidth, alignment: .leading)
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private var imageLayer: some View {
        HeroImageView(imageName: recipe.heroImageName, contentMode: .fill)
    }

    private var cardWidth: CGFloat {
        width ?? 200
    }
}

#Preview {
    RecipeCardView(recipe: SampleData.recipes(for: "Top Picks for You").first ?? Recipe(title: "Sample", subtitle: "Subtitle"))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
