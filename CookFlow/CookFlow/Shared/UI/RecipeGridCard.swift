//
//  RecipeGridCard.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import SwiftUI

struct RecipeGridCard: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    let recipe: Recipe
    var showsYoursBadge: Bool = false
    var imageHeight: CGFloat = 120
    var cardPadding: CGFloat = 10
    var cardSpacing: CGFloat = DesignSystem.Spacing.sm

    var body: some View {
        VStack(alignment: .leading, spacing: cardSpacing) {
            ZStack(alignment: .topLeading) {
                HeroImageView(imageName: recipe.heroImageName)
                    .frame(height: imageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous))

                HStack {
                    if showsYoursBadge {
                        Text("Yours")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.onAccentText)
                            .padding(.horizontal, DesignSystem.Spacing.xs)
                            .padding(.vertical, 4)
                            .background(DesignSystem.Colors.ctaGreen)
                            .clipShape(Capsule())
                    }

                    Spacer()

                    Button(action: { favoritesStore.toggle(id: recipe.id) }) {
                        Image(systemName: favoritesStore.isFavorite(id: recipe.id) ? "heart.fill" : "heart")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(DesignSystem.Colors.primaryText)
                            .frame(width: 30, height: 30)
                            .background(DesignSystem.Colors.card.opacity(0.92))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(8)

            }

            Text(recipe.title)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)

            Text(recipe.subtitle)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .lineLimit(2)

            RecipeMetadataRow(recipe: recipe)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(cardPadding)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview {
    RecipeGridCard(recipe: SampleRecipeFactory.makeSampleRecipes(for: .vegan).first ?? Recipe(title: "Sample", subtitle: "Recipe"))
        .padding()
        .background(DesignSystem.Colors.background)
        .environmentObject(FavoritesStore())
        .preferredColorScheme(.light)
}
