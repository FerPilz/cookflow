//
//  OnboardingFlowView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct OnboardingFlowView: View {
    @State private var stepIndex = 0
    @State private var name = ""
    @State private var email = ""
    @State private var authProvider = ""
    @State private var selectedPreferences: [String] = []
    @State private var optimizationGoal = ""

    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("authProvider") private var storedAuthProvider = ""

    var body: some View {
        OnboardingScaffold(
            primaryCTATitle: primaryCTATitle,
            isPrimaryEnabled: true,
            onPrimaryCTA: advance
        ) {
            headerView
        } bodyContent: {
            currentStepView
        } footerAboveCTAContent: {
            if stepIndex > 0 {
                SecondaryButton(title: "Back", action: back)
            }
        } footerBelowCTAContent: {
            Text("Step \(stepIndex + 1) of \(OnboardingStep.allCases.count)")
                .font(DesignSystem.Fonts.stepLabel)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }

    private var headerView: some View {
        ZStack {
            AppLogoView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: DesignSystem.Spacing.xs) {
                Spacer()
                Text("CookFlow")
                    .font(DesignSystem.Fonts.appName)
                    .foregroundColor(DesignSystem.Colors.textCream)
                Text("Onboarding")
                    .font(DesignSystem.Fonts.stepLabel)
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
            .padding(.bottom, DesignSystem.Spacing.md)
        }
    }

    @ViewBuilder
    private var currentStepView: some View {
        switch OnboardingStep(rawValue: stepIndex) ?? .intro {
        case .intro:
            IntroView()
        case .authName:
            AuthNameView(name: $name, email: $email, authProvider: $authProvider)
        case .preferences:
            PreferencesView(selectedPreferences: $selectedPreferences, optimizationGoal: $optimizationGoal)
        case .welcome:
            WelcomeView(authProvider: authProvider)
        }
    }

    private var primaryCTATitle: String {
        stepIndex == OnboardingStep.allCases.count - 1 ? "Finish" : "Continue"
    }

    private func advance() {
        if stepIndex >= OnboardingStep.allCases.count - 1 {
            storedAuthProvider = authProvider
            hasCompletedOnboarding = true
        } else {
            stepIndex += 1
        }
    }

    private func back() {
        stepIndex = max(0, stepIndex - 1)
    }
}

private enum OnboardingStep: Int, CaseIterable {
    case intro = 0
    case authName
    case preferences
    case welcome
}

#Preview {
    OnboardingFlowView()
}
