//
//  AppShellView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI
import UIKit

struct AppShellView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var selectedTab: AppTab = .home
    @State private var homePath = NavigationPath()
    @State private var searchPath = NavigationPath()
    @State private var plannerPath = NavigationPath()
    @State private var favoritesPath = NavigationPath()
    @State private var aiRecipesPath = NavigationPath()
    @State private var isMenuPresented = false
    @State private var isProfilePresented = false
    @State private var isCartPresented = false
    @StateObject private var favoritesStore = FavoritesStore()
    @StateObject private var cartStore = CartStore()
    @StateObject private var plannerStore = PlannerStore()
    @StateObject private var shoppingListStore = ShoppingListStore()

    var body: some View {
        let colors = themeManager.palette

        ZStack {
            colors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                AppTopBarView(
                    onTapMenu: { isMenuPresented = true },
                    onTapCart: { isCartPresented = true },
                    onTapProfile: { isProfilePresented = true },
                    cartItemCount: cartStore.items.count
                )

                ZStack {
                    switch selectedTab {
                    case .home:
                        NavigationStack(path: $homePath) {
                            HomeView()
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    case .search:
                        NavigationStack(path: $searchPath) {
                            SearchView()
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    case .planner:
                        NavigationStack(path: $plannerPath) {
                            PlannerView()
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    case .favorites:
                        NavigationStack(path: $favoritesPath) {
                            FavoritesView()
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    case .aiRecipes:
                        NavigationStack(path: $aiRecipesPath) {
                            AIRecipesView()
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    }
                }
            }

            if isMenuPresented {
                colors.primaryText.opacity(0.18)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.22)) {
                            isMenuPresented = false
                        }
                    }

                HStack(spacing: 0) {
                    MenuView(
                        isPresented: $isMenuPresented,
                        selectedTab: $selectedTab,
                        onTapProfile: {
                            isProfilePresented = true
                        }
                    )
                    .frame(width: UIScreen.main.bounds.width * 0.54)
                    .transition(.move(edge: .leading))

                    Spacer(minLength: 0)
                }
            }
        }
        .animation(.easeInOut(duration: 0.22), value: isMenuPresented)
        .safeAreaInset(edge: .bottom) {
            BottomTabBarView(
                selectedTab: $selectedTab,
                onSelectTab: handleTabSelection
            )
        }
        .sheet(isPresented: $isProfilePresented) {
            ProfileView()
        }
        .sheet(isPresented: $isCartPresented) {
            CartView()
        }
        .onChange(of: selectedTab) { _, newTab in
            resetPath(for: newTab)
        }
        .environmentObject(favoritesStore)
        .environmentObject(cartStore)
        .environmentObject(plannerStore)
        .environmentObject(shoppingListStore)
    }

    private func handleTabSelection(_ newTab: AppTab) {
        if selectedTab == newTab {
            resetPath(for: newTab)
        } else {
            selectedTab = newTab
            resetPath(for: newTab)
        }
    }

    private func resetPath(for tab: AppTab) {
        switch tab {
        case .home:
            homePath = NavigationPath()
        case .search:
            searchPath = NavigationPath()
        case .planner:
            plannerPath = NavigationPath()
        case .favorites:
            favoritesPath = NavigationPath()
        case .aiRecipes:
            aiRecipesPath = NavigationPath()
        }
    }
}

#Preview("Root Light") {
    AppShellView()
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}
