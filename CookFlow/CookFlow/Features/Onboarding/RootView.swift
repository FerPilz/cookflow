//
//  RootView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("authProvider") private var authProvider = ""

    var body: some View {
        if hasCompletedOnboarding {
            MainPlaceholderView(authProvider: authProvider)
        } else {
            OnboardingFlowView()
        }
    }
}

private struct MainPlaceholderView: View {
    let authProvider: String

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()
            VStack(spacing: DesignSystem.Spacing.md) {
                Text("Home goes here")
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                if !authProvider.isEmpty {
                    Text("Signed in via \(authProvider)")
                        .font(DesignSystem.Fonts.body)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
            }
        }
    }
}

#Preview {
    RootView()
}
