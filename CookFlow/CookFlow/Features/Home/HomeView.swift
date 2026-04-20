//
//  HomeView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct HomeView: View {
    private static let fallbackHeroRecipeIDs = [
        "pro_001_chicken_chorizo_jambalaya_a",
        "brk_001_good_old_fashioned_pancakes_b",
        "hlt_001_marry_me_white_bean_soup_kale_b",
        "mlp_001_chicken_burrito_bowls_c",
        "dte_001_filet_mignon_red_wine_pan_sauce_a",
    ]

    @EnvironmentObject private var favoritesStore: FavoritesStore
    @EnvironmentObject private var themeManager: ThemeManager
    @AppStorage("recentlyViewedRecipeIDs") private var recentlyViewedRecipeIDs = ""
    @StateObject private var userRecipesStore = UserRecipesStore()
    @State private var activeCategoryTitle = "Featured"
    private let stickyHeaderBaseHeight: CGFloat = HomeStickyHeaderView.baseHeight
    private let sectionScrollRevealPadding: CGFloat = HomeStickyHeaderView.baseHeight + DesignSystem.Spacing.md

    var body: some View {
        let colors = themeManager.palette

        GeometryReader { geometry in
            let stickyHeaderHeight = stickyHeaderBaseHeight + geometry.safeAreaInsets.top

            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    colors.background
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                            Color.clear
                                .frame(height: stickyHeaderHeight - 4)

                            HomeHeroView(
                                title: "Featured",
                                recipes: heroRecipes,
                                favoriteIDs: favoritesStore.favoriteIDs,
                                onToggleFavorite: { favoritesStore.toggle(id: $0.id) },
                                onSelectRecipe: recordRecentlyViewed
                            )
                            .id("hero")
                            .overlay(alignment: .top) {
                                sectionScrollAnchor(for: "Featured")
                            }
                            .background(sectionOffsetReader(title: "Featured"))

                            ForEach(secondaryHomeSectionTitles, id: \.self) { title in
                                let recipes = SampleData.recipes(forHomeSectionTitle: title, userRecipes: userRecipesStore.recipes)
                                if !recipes.isEmpty {
                                    HomeSectionView(
                                        title: title,
                                        recipes: recipes,
                                        favoriteIDs: favoritesStore.favoriteIDs,
                                        onToggleFavorite: { favoritesStore.toggle(id: $0.id) },
                                        onSelectRecipe: recordRecentlyViewed
                                    )
                                    .id(sectionID(for: title))
                                    .overlay(alignment: .top) {
                                        sectionScrollAnchor(for: title)
                                    }
                                    .background(sectionOffsetReader(title: title))
                                }
                            }

                            if !recentlyViewedRecipes.isEmpty {
                                HomeSectionView(
                                    title: "Continue Cooking",
                                    recipes: recentlyViewedRecipes,
                                    favoriteIDs: favoritesStore.favoriteIDs,
                                    onToggleFavorite: { favoritesStore.toggle(id: $0.id) },
                                    onSelectRecipe: recordRecentlyViewed
                                )
                                .id("continue-cooking")
                                .background(sectionOffsetReader(title: "Continue Cooking"))
                            }
                        }
                        .padding(.horizontal, DesignSystem.Spacing.lg)
                        .padding(.bottom, 96)
                    }
                    .coordinateSpace(name: "home-scroll")
                    .onPreferenceChange(HomeSectionOffsetPreferenceKey.self) { offsets in
                        updateActiveCategory(from: offsets, stickyHeaderHeight: stickyHeaderHeight)
                    }

                    HomeStickyHeaderView(
                        topInset: geometry.safeAreaInsets.top,
                        categories: homeCategories,
                        selectedCategoryTitle: activeCategoryTitle,
                        onSelectCategory: { category in
                            activeCategoryTitle = category.title
                            withAnimation(.easeInOut(duration: 0.22)) {
                                proxy.scrollTo(sectionAnchorID(for: category.title), anchor: .top)
                            }
                        }
                    )
                }
            }
        }
        .background(colors.background)
        .ignoresSafeArea()
    }

    private var homeSectionTitles: [String] {
        homeCategories.map(\.title)
    }

    private var secondaryHomeSectionTitles: [String] {
        homeSectionTitles.filter { $0 != "Featured" }
    }

    private var homeCategories: [Category] {
        SampleData.homeCategories()
    }

    private var heroRecipes: [Recipe] {
        let recipes = SampleData.recipes(forHomeSectionTitle: "Featured", userRecipes: userRecipesStore.recipes)
        if !recipes.isEmpty {
            return Array(recipes.prefix(5))
        }

        let firstSectionRecipes = SampleData.recipes(
            forHomeSectionTitle: "Featured",
            userRecipes: userRecipesStore.recipes
        )
        if !firstSectionRecipes.isEmpty {
            return Array(firstSectionRecipes.prefix(5))
        }

        return Self.fallbackHeroRecipeIDs.compactMap { id in
            SampleData.allRecipes.first(where: { $0.id == id })
        }
    }

    private var recentlyViewedRecipes: [Recipe] {
        let ids = recentlyViewedRecipeIDs
            .split(separator: ",")
            .map(String.init)

        let recipes = ids.compactMap { id in
            SampleData.allRecipes.first(where: { $0.id == id })
        }

        return Array(recipes.prefix(5))
    }

    private func sectionID(for title: String) -> String {
        return Category(title: title, systemImageName: "circle.fill").slug
    }

    private func sectionAnchorID(for title: String) -> String {
        "\(sectionID(for: title))-anchor"
    }

    private func recordRecentlyViewed(_ recipe: Recipe) {
        var ids = recentlyViewedRecipeIDs
            .split(separator: ",")
            .map(String.init)

        ids.removeAll { $0 == recipe.id }
        ids.insert(recipe.id, at: 0)
        recentlyViewedRecipeIDs = Array(ids.prefix(8)).joined(separator: ",")
    }

    private func sectionOffsetReader(title: String) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(
                    key: HomeSectionOffsetPreferenceKey.self,
                    value: [title: geometry.frame(in: .named("home-scroll")).minY]
                )
        }
    }

    private func sectionScrollAnchor(for title: String) -> some View {
        Color.clear
            .frame(height: 1)
            .id(sectionAnchorID(for: title))
            .offset(y: -sectionScrollRevealPadding)
            .allowsHitTesting(false)
            .accessibilityHidden(true)
    }

    private func updateActiveCategory(from offsets: [String: CGFloat], stickyHeaderHeight: CGFloat) {
        let activationY = stickyHeaderHeight + 24
        let categoryTitles = Set(homeCategories.map(\.title))
        let relevantOffsets = offsets.filter { categoryTitles.contains($0.key) }

        let currentTitle = relevantOffsets
            .filter { $0.value <= activationY }
            .max(by: { $0.value < $1.value })?
            .key
            ?? relevantOffsets.min(by: { $0.value < $1.value })?.key
            ?? activeCategoryTitle

        if currentTitle != activeCategoryTitle {
            activeCategoryTitle = currentTitle
        }
    }
}

#Preview("Light Mode") {
    NavigationStack {
        HomeView()
            .environmentObject(FavoritesStore())
            .environmentObject(ThemeManager(theme: .light))
            .environment(\.colorScheme, .light)
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        HomeView()
            .environmentObject(FavoritesStore())
            .environmentObject(ThemeManager(theme: .dark))
            .environment(\.colorScheme, .dark)
    }
}
