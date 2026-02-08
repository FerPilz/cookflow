//
//  AllRecipesView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct AllRecipesView: View {
    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            VStack(spacing: DesignSystem.Spacing.md) {
                Text("All Recipes")
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                Text("Browse every recipe in CookFlow.")
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
        }
    }
}

#Preview {
    AllRecipesView()
        .preferredColorScheme(.dark)
}
