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
        } footerBelowCTAContent: {
            if currentStep == .intro {
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Button(action: { print("TODO: Preview recipes") }) {
                        Text("Preview recipes")
                            .font(DesignSystem.Fonts.link)
                            .foregroundColor(Color.accentColor)
                    }
                    .buttonStyle(.plain)

                    HStack(spacing: 6) {
                        Text("Already have an account?")
                            .font(DesignSystem.Fonts.link)
                            .foregroundColor(DesignSystem.Colors.textMuted)

                        Button(action: { print("TODO: Sign in") }) {
                            Text("Sign in")
                                .font(DesignSystem.Fonts.link)
                                .foregroundColor(Color.accentColor)
                        }
                        .buttonStyle(.plain)
                    }

                    Text("1 of 4")
                        .font(DesignSystem.Fonts.stepLabel)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else if currentStep == .preferences {
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Button(action: completeOnboarding) {
                        Text("Skip for now")
                            .font(DesignSystem.Fonts.link)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    }
                    .buttonStyle(.plain)

                    Text("\(stepIndex + 1) of \(OnboardingStep.allCases.count)")
                        .font(DesignSystem.Fonts.stepLabel)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Text("\(stepIndex + 1) of \(OnboardingStep.allCases.count)")
                    .font(DesignSystem.Fonts.stepLabel)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .frame(maxWidth: .infinity, alignment: .bottom)
            }
        }
    }

    @ViewBuilder
    private var headerView: some View {
        VStack(spacing: 10) {
            AppLogoView(size: 140)
            Text("CookFlow")
                .font(DesignSystem.Fonts.stepLabel)
                .foregroundColor(DesignSystem.Colors.textCream)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }




    @ViewBuilder
    private var currentStepView: some View {
        switch currentStep {
        case .intro:
            IntroView()
        case .authName:
            AuthNameView(name: $name, email: $email, authProvider: $authProvider)
        case .preferences:
            PreferencesView(selectedPreferences: $selectedPreferences, optimizationGoal: $optimizationGoal)
        case .welcome:
            WelcomeView(name: name)
        }
    }

    private var primaryCTATitle: String {
        if currentStep == .intro {
            return "Get started"
        }
        return stepIndex == OnboardingStep.allCases.count - 1 ? "Start Cooking" : "Continue"
    }

    private func advance() {
        if stepIndex >= OnboardingStep.allCases.count - 1 {
            completeOnboarding()
        } else {
            stepIndex += 1
        }
    }

    private var currentStep: OnboardingStep {
        OnboardingStep(rawValue: stepIndex) ?? .intro
    }

    private func completeOnboarding() {
        storedAuthProvider = authProvider
        hasCompletedOnboarding = true
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
        .preferredColorScheme(.dark)
}
