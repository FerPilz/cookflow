//
//  WelcomeView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct WelcomeView: View {
    let authProvider: String

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("All set")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
            Text("Auth: \(authProvider.isEmpty ? "Not selected" : authProvider)")
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
        .padding(.horizontal, DesignSystem.Spacing.xl)
    }
}

#Preview {
    WelcomeView(authProvider: "")
        .preferredColorScheme(.dark)
    
}
