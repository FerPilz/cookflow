//
//  AppTopBarView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct AppTopBarView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    let onTapMenu: () -> Void
    let onTapCart: () -> Void
    let onTapProfile: () -> Void
    let cartItemCount: Int

    init(
        onTapMenu: @escaping () -> Void = {},
        onTapCart: @escaping () -> Void = {},
        onTapProfile: @escaping () -> Void = {},
        cartItemCount: Int = 0
    ) {
        self.onTapMenu = onTapMenu
        self.onTapCart = onTapCart
        self.onTapProfile = onTapProfile
        self.cartItemCount = cartItemCount
    }

    var body: some View {
        let colors = themeManager.palette

        ZStack {
            HStack {
                HStack {
                    IconButton(systemName: "line.3.horizontal", action: onTapMenu)
                    Spacer(minLength: 0)
                }
                .frame(width: 96, alignment: .leading)

                Spacer()

                HStack(spacing: DesignSystem.Spacing.xs) {
                    CartIconButton(
                        systemName: "cart",
                        badgeCount: cartItemCount,
                        action: onTapCart
                    )
                    IconButton(systemName: "person.crop.circle", action: onTapProfile)
                }
                .frame(width: 96, alignment: .trailing)
            }

            AppLogoView(size: 28)
                .allowsHitTesting(false)
        }
        .frame(height: 64)
        .padding(.horizontal, 18)
        .background(colors.topBarBackground)
    }
}

private struct IconButton: View {
    @EnvironmentObject private var themeManager: ThemeManager
    let systemName: String
    let action: () -> Void

    var body: some View {
        let colors = themeManager.palette

        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(colors.primaryText)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
    }
}

private struct CartIconButton: View {
    @EnvironmentObject private var themeManager: ThemeManager
    let systemName: String
    let badgeCount: Int
    let action: () -> Void

    var body: some View {
        let colors = themeManager.palette

        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: systemName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(colors.primaryText)
                    .frame(width: 44, height: 44)

                if badgeCount > 0 {
                    Text(badgeText)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(DesignSystem.Colors.onAccentText)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(colors.accent)
                        .clipShape(Capsule())
                        .offset(x: 6, y: -4)
                }
            }
        }
        .buttonStyle(.plain)
    }

    private var badgeText: String {
        badgeCount > 99 ? "99+" : "\(badgeCount)"
    }
}

#Preview {
    AppTopBarView()
        .environmentObject(CartStore())
        .environmentObject(ThemeManager())
}
