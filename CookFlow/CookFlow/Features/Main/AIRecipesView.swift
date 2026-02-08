//
//  AIRecipesView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct AIRecipesView: View {
    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            Text("AI Recipes")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
        }
    }
}

#Preview {
    AIRecipesView()
        .preferredColorScheme(.dark)
}
