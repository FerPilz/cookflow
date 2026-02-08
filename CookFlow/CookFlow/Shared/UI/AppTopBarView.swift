//
//  AppTopBarView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct AppTopBarView: View {
    let onTapMenu: () -> Void
    let onTapCart: () -> Void
    let onTapProfile: () -> Void

    init(
        onTapMenu: @escaping () -> Void = {},
        onTapCart: @escaping () -> Void = {},
        onTapProfile: @escaping () -> Void = {}
    ) {
        self.onTapMenu = onTapMenu
        self.onTapCart = onTapCart
        self.onTapProfile = onTapProfile
    }

    var body: some View {
        ZStack {
            AppLogoView(size: 120)

            HStack {
                IconButton(systemName: "line.3.horizontal", action: onTapMenu)

                Spacer()

                HStack(spacing: DesignSystem.Spacing.xs) {
                    IconButton(systemName: "cart", action: onTapCart)
                    IconButton(systemName: "person.crop.circle", action: onTapProfile)
                }
            }
        }
        .frame(height: 64)
        .padding(.horizontal, 18)
        .background(DesignSystem.Colors.backgroundNearBlack)
    }
}

private struct IconButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AppTopBarView()
        .preferredColorScheme(.dark)
}
