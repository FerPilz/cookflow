//
//  FavoritesView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                    if favoritesStore.favoriteIDs.isEmpty {
                        Text("No favorites yet")
                            .font(DesignSystem.Fonts.subtitle)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    } else {
                        ForEach(sortedCategories, id: \.self) { category in
                            if let recipes = favoritesStore.favoritesByCategory[category] {
                                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                                    Text(category)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(DesignSystem.Colors.textCream)

                                    ForEach(recipes) { recipe in
                                        HStack(spacing: DesignSystem.Spacing.sm) {
                                            RecipeThumbView(recipe: recipe)

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
                                        .padding(DesignSystem.Spacing.sm)
                                        .background(DesignSystem.Colors.card)
                                        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, 96)
            }
        }
    }

    private var sortedCategories: [String] {
        favoritesStore.favoritesByCategory.keys.sorted()
    }
}

private struct RecipeThumbView: View {
    let recipe: Recipe

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
        .frame(width: 56, height: 56)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private var placeholder: some View {
        LinearGradient(
            colors: [DesignSystem.Colors.card, DesignSystem.Colors.backgroundNearBlack],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesStore())
        .preferredColorScheme(.dark)
}
