//
//  SearchView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var searchText = ""
    @State private var isShowingAddRecipe = false
    @State private var isShowingImportURL = false
    @StateObject private var userRecipesStore = UserRecipesStore()

    let selectionTitle: String?
    let onSelectRecipe: ((Recipe) -> Void)?

    init(
        selectionTitle: String? = nil,
        onSelectRecipe: ((Recipe) -> Void)? = nil
    ) {
        self.selectionTitle = selectionTitle
        self.onSelectRecipe = onSelectRecipe
    }

    private let recipeColumns: [GridItem] = [
        GridItem(.flexible(minimum: 0), spacing: 8),
        GridItem(.flexible(minimum: 0), spacing: 8),
        GridItem(.flexible(minimum: 0), spacing: 8)
    ]
    var body: some View {
        let colors = themeManager.palette

        ScrollView {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                SearchBar(text: $searchText, placeholder: "Search by recipe title or ingredients")

                if let selectionTitle {
                    Text(selectionTitle)
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(colors.secondaryText)
                }

                actionButtons

                if trimmedQuery.isEmpty {
                    browseState
                } else if matchedRecipes.isEmpty {
                    emptyState
                } else {
                    resultsState
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, DesignSystem.Spacing.md)
            .padding(.bottom, 96)
        }
        .background(colors.background)
        .sheet(isPresented: $isShowingAddRecipe) {
            AddRecipeView(userRecipesStore: userRecipesStore)
        }
        .sheet(isPresented: $isShowingImportURL) {
            ImportRecipeURLView(userRecipesStore: userRecipesStore)
        }
    }

    private var actionButtons: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            actionButton(title: "Import Recipe", systemName: "square.and.arrow.down", action: {
                isShowingImportURL = true
            })

            actionButton(title: "Add Own Recipe", systemName: "plus", action: {
                isShowingAddRecipe = true
            })
        }
    }

    private func actionButton(title: String, systemName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemName)
                    .font(.system(size: 12, weight: .semibold))

                Text(title)
                    .font(DesignSystem.Fonts.valueProp)
            }
            .foregroundColor(DesignSystem.Colors.ctaGreen)
            .padding(.horizontal, DesignSystem.Spacing.md)
            .padding(.vertical, DesignSystem.Spacing.sm)
            .frame(maxWidth: .infinity)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private var browseState: some View {
        VStack(alignment: .leading, spacing: 20) {
            if !myRecipesSectionRecipes.isEmpty {
                myRecipesEntry
            }

            ForEach(SampleData.searchBrowseSections) { section in
                browseSection(section)
            }
        }
    }

    private var resultsState: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Results")
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                Text("\(matchedRecipes.count) recipes matched title or ingredients.")
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }

            LazyVGrid(columns: recipeColumns, spacing: 8) {
                ForEach(matchedRecipes) { recipe in
                    recipeCell(for: recipe)
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text("No matches yet")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            Text("Try a recipe title like pasta or salmon, or ingredient terms separated by commas such as chicken, garlic.")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .fixedSize(horizontal: false, vertical: true)

            Text("You can also import a recipe or add your own to keep building your library.")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(DesignSystem.Spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private var trimmedQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var allRecipes: [Recipe] {
        var seen = Set<String>()
        let combined = SampleData.allRecipes
            + SampleRecipeFactory.makeSampleRecipes(for: .snacks)
            + userRecipesStore.recipes

        return combined.filter { recipe in
            guard !seen.contains(recipe.id) else { return false }
            seen.insert(recipe.id)
            return true
        }
    }

    private var matchedRecipes: [Recipe] {
        guard !trimmedQuery.isEmpty else { return [] }

        return allRecipes.filter { $0.matchesSearchQuery(trimmedQuery) }
    }

    @ViewBuilder
    private func recipeCell(for recipe: Recipe) -> some View {
        if let onSelectRecipe {
            Button(action: { onSelectRecipe(recipe) }) {
                RecipeGridCard(
                    recipe: recipe,
                    showsYoursBadge: recipe.isUserCreated,
                    imageHeight: 108,
                    cardPadding: 8,
                    cardSpacing: 8
                )
            }
            .buttonStyle(.plain)
        } else {
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeGridCard(
                    recipe: recipe,
                    showsYoursBadge: recipe.isUserCreated,
                    imageHeight: 108,
                    cardPadding: 8,
                    cardSpacing: 8
                )
            }
            .buttonStyle(.plain)
        }
    }

    private var myRecipesEntry: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Your Library")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            NavigationLink(
                destination: CategoryRecipesScreen(
                    title: "My Recipes",
                    recipes: myRecipesSectionRecipes,
                    userRecipesStore: userRecipesStore,
                    onSelectRecipe: onSelectRecipe
                )
            ) {
                HStack(spacing: DesignSystem.Spacing.md) {
                    CategoryThumbnailView(
                        imageName: myRecipesSectionRecipes.first?.heroImageName,
                        size: 70,
                        systemImageName: Category.metadataByTitle["My Recipes"]?.symbolName ?? "book.closed.fill",
                        presentation: .circle
                    )

                    VStack(alignment: .leading, spacing: 4) {
                        Text("My Recipes")
                            .font(DesignSystem.Fonts.subtitle)
                            .foregroundColor(DesignSystem.Colors.textCream)

                        Text("\(userRecipesStore.recipes.count) saved recipes")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .padding(DesignSystem.Spacing.md)
                .background(DesignSystem.Colors.card)
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous)
                        .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
    }

    private func browseSection(_ section: SampleData.BrowseSection) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(section.title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)

            GeometryReader { geometry in
                let itemSpacing = DesignSystem.Spacing.sm
                let visibleItemWidth = max(98, (geometry.size.width - (itemSpacing * 2)) / 3)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: itemSpacing) {
                        ForEach(section.items) { category in
                            browseCategoryLink(for: category)
                                .frame(width: visibleItemWidth)
                        }
                    }
                }
            }
            .frame(height: 130)
        }
    }

    private func browseCategoryLink(for category: Category) -> some View {
        let recipes = SampleData.recipes(forBrowseCategoryTitle: category.title)

        return NavigationLink(
            destination: CategoryRecipesScreen(
                title: category.title,
                recipes: recipes,
                userRecipesStore: userRecipesStore,
                onSelectRecipe: onSelectRecipe
            )
        ) {
            CategoryCardView(
                category: category,
                thumbnailImageName: SampleData.thumbnailImageName(forBrowseCategoryTitle: category.title)
            )
        }
        .buttonStyle(.plain)
    }

    private func recipeSection(title: String, recipes: [Recipe]) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text(title)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            LazyVGrid(columns: recipeColumns, spacing: 8) {
                ForEach(recipes.prefix(9)) { recipe in
                    recipeCell(for: recipe)
                }
            }
        }
    }

    private var myRecipesSectionRecipes: [Recipe] {
        let recipes = userRecipesStore.recipes
            .sorted { $0.createdAt > $1.createdAt }
        guard !recipes.isEmpty else { return [] }

        if recipes.count >= 9 {
            return Array(recipes.prefix(9))
        }

        return Array(recipes.cycled(toCount: 9))
    }

}

private extension Array {
    func cycled(toCount count: Int) -> [Element] {
        guard !isEmpty, count > 0 else { return [] }

        return (0..<count).map { index in
            self[index % self.count]
        }
    }
}

#Preview("Light Mode") {
    NavigationStack {
        SearchView()
            .environmentObject(FavoritesStore())
            .environmentObject(ThemeManager(theme: .light))
            .environment(\.colorScheme, .light)
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        SearchView()
            .environmentObject(FavoritesStore())
            .environmentObject(ThemeManager(theme: .dark))
            .environment(\.colorScheme, .dark)
    }
}
