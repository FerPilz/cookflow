//
//  BottomTabBarView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

enum AppTab: CaseIterable {
    case home
    case search
    case planner
    case favorites
    case aiRecipes

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .planner:
            return "Planner"
        case .favorites:
            return "Favorites"
        case .aiRecipes:
            return "AI Recipes"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .planner:
            return "calendar"
        case .favorites:
            return "heart"
        case .aiRecipes:
            return "sparkles"
        }
    }
}

struct BottomTabBarView: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(DesignSystem.Colors.divider)
                .frame(height: 1)

            HStack {
                ForEach(AppTab.allCases, id: \.self) { tab in
                    tabButton(for: tab)
                }
            }
            .frame(height: 72)
            .padding(.horizontal, DesignSystem.Spacing.sm)
            .background(DesignSystem.Colors.backgroundNearBlack)
        }
    }

    private func tabButton(for tab: AppTab) -> some View {
        let isSelected = selectedTab == tab
        let foreground = isSelected ? Color.accentColor : DesignSystem.Colors.textMuted
        return Button(action: { selectedTab = tab }) {
            VStack(spacing: 4) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 18, weight: .semibold))

                Text(tab.title)
                    .font(DesignSystem.Fonts.valueProp)
            }
            .foregroundColor(foreground)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(tab.title)
    }
}

#Preview {
    BottomTabBarView(selectedTab: .constant(.home))
        .preferredColorScheme(.dark)
}
