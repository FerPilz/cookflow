//
//  FavoritesView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        let colors = themeManager.palette

        ZStack {
            colors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                    if favoritesStore.favoriteIDs.isEmpty {
                        Text("No favorites yet")
                            .font(DesignSystem.Fonts.subtitle)
                            .foregroundColor(colors.secondaryText)
                    } else {
                        ForEach(sortedCategories, id: \.self) { category in
                            if let recipes = favoritesStore.favoritesByCategory[category] {
                                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                                    Text(category)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(colors.primaryText)

                                    ForEach(recipes) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            HStack(spacing: DesignSystem.Spacing.sm) {
                                                RecipeThumbView(recipe: recipe)

                                                VStack(alignment: .leading, spacing: 2) {
                                                    Text(recipe.title)
                                                        .font(DesignSystem.Fonts.subtitle)
                                                        .foregroundColor(colors.primaryText)

                                                    Text(recipe.subtitle)
                                                        .font(DesignSystem.Fonts.valueProp)
                                                        .foregroundColor(colors.secondaryText)
                                                        .lineLimit(1)

                                                    RecipeMetadataRow(
                                                        recipe: recipe,
                                                        iconColor: colors.accent,
                                                        textColor: colors.secondaryText
                                                    )
                                                }

                                                Spacer()

                                                Button(action: { favoritesStore.toggle(id: recipe.id) }) {
                                                    Image(systemName: favoritesStore.isFavorite(id: recipe.id) ? "heart.fill" : "heart")
                                                        .font(.system(size: 14, weight: .semibold))
                                                        .foregroundColor(colors.primaryText)
                                                        .padding(8)
                                                        .background(colors.secondaryBackground.opacity(0.9))
                                                        .clipShape(Circle())
                                                }
                                                .buttonStyle(.plain)
                                            }
                                            .padding(DesignSystem.Spacing.sm)
                                            .background(colors.cardBackground)
                                            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                                        }
                                        .buttonStyle(.plain)
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
        HeroImageView(imageName: recipe.heroImageName)
        .frame(width: 56, height: 56)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview("Light Mode") {
    FavoritesView()
        .environmentObject(FavoritesStore())
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}

#Preview("Dark Mode") {
    FavoritesView()
        .environmentObject(FavoritesStore())
        .environmentObject(ThemeManager(theme: .dark))
        .environment(\.colorScheme, .dark)
}
