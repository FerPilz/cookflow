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
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            Text("Welcome to CookFlow 1.0")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .multilineTextAlignment(.center)
            .padding(.horizontal, DesignSystem.Spacing.xl)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView(name: "")
        .preferredColorScheme(.dark)
}
