//
//  CategoryRecipesScreen.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import SwiftUI

struct CategoryRecipesScreen: View {
    @Environment(\.dismiss) private var dismiss
    private let title: String
    private let builtInRecipes: [Recipe]
    private let userRecipeFilter: ((Recipe) -> Bool)?
    @ObservedObject var userRecipesStore: UserRecipesStore
    let onSelectRecipe: ((Recipe) -> Void)?

    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 0), spacing: 12),
        GridItem(.flexible(minimum: 0), spacing: 12)
    ]

    init(
        category: RecipeCategory,
        userRecipesStore: UserRecipesStore,
        onSelectRecipe: ((Recipe) -> Void)?
    ) {
        self.title = category.rawValue
        self.builtInRecipes = Array(SampleRecipeFactory.makeSampleRecipes(for: category).prefix(5))
        self.userRecipeFilter = { RecipeCategory.from(categoryTitle: $0.category) == category }
        self.userRecipesStore = userRecipesStore
        self.onSelectRecipe = onSelectRecipe
    }

    init(
        title: String,
        recipes: [Recipe],
        userRecipesStore: UserRecipesStore,
        onSelectRecipe: ((Recipe) -> Void)?
    ) {
        self.title = title
        self.builtInRecipes = recipes
        self.userRecipeFilter = nil
        self.userRecipesStore = userRecipesStore
        self.onSelectRecipe = onSelectRecipe
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(width: 32, height: 32)
                        .background(DesignSystem.Colors.card)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                Text(title)
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .lineLimit(1)

                Spacer()
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, DesignSystem.Spacing.sm)
            .padding(.bottom, DesignSystem.Spacing.sm)
            .background(DesignSystem.Colors.backgroundNearBlack)
            .zIndex(1)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(recipes) { recipe in
                        recipeCell(for: recipe)
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, 96)
            }
        }
        .background(DesignSystem.Colors.backgroundNearBlack)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var recipes: [Recipe] {
        var seen = Set<String>()
        let user = userRecipeFilter.map { filter in
            userRecipesStore.recipes.filter(filter)
        } ?? []

        return (user + builtInRecipes).filter { recipe in
            seen.insert(recipe.id).inserted
        }
    }

    @ViewBuilder
    private func recipeCell(for recipe: Recipe) -> some View {
        if let onSelectRecipe {
            Button(action: { onSelectRecipe(recipe) }) {
                RecipeGridCard(recipe: recipe, showsYoursBadge: recipe.isUserCreated)
            }
            .buttonStyle(.plain)
        } else {
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeGridCard(recipe: recipe, showsYoursBadge: recipe.isUserCreated)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        CategoryRecipesScreen(category: .vegan, userRecipesStore: UserRecipesStore(), onSelectRecipe: nil)
    }
    .environmentObject(FavoritesStore())
    .preferredColorScheme(.dark)
}
