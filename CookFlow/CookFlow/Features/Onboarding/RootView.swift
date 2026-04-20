//
//  RootView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        Group {
            if hasCompletedOnboarding {
                AppShellView()
                    .task {
                        SeedImporter.importIfNeeded(modelContext: modelContext)
                        #if DEBUG
                        SampleData.validateHeroAssets()
                        #endif
                    }
            } else {
                OnboardingFlowView()
            }
        }
        .onAppear {
            themeManager.updateSystemColorScheme(colorScheme)
        }
        .onChange(of: colorScheme) { _, newValue in
            themeManager.updateSystemColorScheme(newValue)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(ThemeManager())
}
