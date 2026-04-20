//
//  MainTabView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection: Tab = .home

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(Tab.favorites)

            AllRecipesView()
                .tabItem {
                    Label("All Recipes", systemImage: "square.grid.2x2")
                }
                .tag(Tab.allRecipes)
        }
    }
}

private enum Tab {
    case home
    case search
    case favorites
    case allRecipes
}

#Preview {
    MainTabView()
        .environmentObject(ThemeManager())
        .environmentObject(FavoritesStore())
        .environmentObject(CartStore())
        .environmentObject(PlannerStore())
        .environmentObject(ShoppingListStore())
}
