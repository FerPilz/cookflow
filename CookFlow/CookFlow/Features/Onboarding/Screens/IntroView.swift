//
//  IntroView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("Welcome to CookFlow")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
            Text("This is a placeholder screen for step 1.")
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
        .padding(.horizontal, DesignSystem.Spacing.xl)
    }
}

#Preview {
    IntroView()
}
