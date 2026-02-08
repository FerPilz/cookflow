//
//  AppShellView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct AppShellView: View {
    @State private var selectedTab: AppTab = .home
    @State private var isMenuPresented = false
    @State private var isProfilePresented = false
    @State private var isCartPresented = false
    @StateObject private var favoritesStore = FavoritesStore()

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            VStack(spacing: 0) {
                AppTopBarView(
                    onTapMenu: { isMenuPresented = true },
                    onTapCart: { isCartPresented = true },
                    onTapProfile: { isProfilePresented = true }
                )

                ZStack {
                    switch selectedTab {
                    case .home:
                        HomeView()
                    case .search:
                        SearchView()
                    case .planner:
                        PlannerView()
                    case .favorites:
                        FavoritesView()
                    case .aiRecipes:
                        AIRecipesView()
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            BottomTabBarView(selectedTab: $selectedTab)
        }
        .sheet(isPresented: $isMenuPresented) {
            MenuView(isPresented: $isMenuPresented, selectedTab: $selectedTab)
        }
        .sheet(isPresented: $isProfilePresented) {
            ProfileView()
        }
        .sheet(isPresented: $isCartPresented) {
            GroceryListView()
        }
        .environmentObject(favoritesStore)
    }
}

#Preview {
    AppShellView()
        .preferredColorScheme(.dark)
}
