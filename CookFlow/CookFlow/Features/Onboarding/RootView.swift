//
//  RootView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        if hasCompletedOnboarding {
            AppShellView()
        } else {
            OnboardingFlowView()
        }
    }
}

#Preview {
    RootView()
}
