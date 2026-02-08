//
//  WelcomeView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct WelcomeView: View {
    let name: String

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("WELCOME")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .multilineTextAlignment(.center)

            Text(name.isEmpty ? "CookFlow" : name)
                .font(DesignSystem.Fonts.heroTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .multilineTextAlignment(.center)

            Text("YOUR PERSONALIZED COOKBOOK IS READY!")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, DesignSystem.Spacing.xl)
    }
}

#Preview {
    WelcomeView(name: "Gaby")
        .preferredColorScheme(.dark)
    
}
