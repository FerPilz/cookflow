//
//  OnboardingFlowView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

struct OnboardingFlowView: View {
    @State private var stepIndex = 0
    @State private var email = ""
    @State private var authProvider = ""
    @State private var selectedPreferences: [String] = []
    @State private var optimizationGoal = ""
    @State private var hasPreferenceSelection = false
    @State private var preferenceStepIndex = 0

    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("authProvider") private var storedAuthProvider = ""
    private let introValueProps: [(icon: String, title: String)] = [
        ("calendar.badge.clock", "Plan meals in minutes"),
        ("dumbbell", "Fit your goals (calories & macros)"),
        ("sparkles", "AI help while you cook")
    ]
    private let totalPreferenceSteps = 5
    private let onboardingLogoSize: CGFloat = 108

    var body: some View {
        if currentStep == .welcome {
            AnimatedWelcomeView(onFinished: completeOnboarding)
        } else {
            OnboardingScaffold(
                primaryCTATitle: primaryCTATitle,
                showsPrimaryCTA: true,
                isPrimaryEnabled: currentStep != .preferences || hasPreferenceSelection,
                onPrimaryCTA: advance,
                usesVideoBackground: currentStep == .intro,
                videoResourceName: "intro_loop",
                showsTopBanner: currentStep == .authName
            ) {
                headerView
            } bodyContent: {
                currentStepView
            } footerAboveCTAContent: {
                if currentStep == .intro {
                    VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                        ForEach(Array(introValueProps.enumerated()), id: \.offset) { _, item in
                            HStack(spacing: DesignSystem.Spacing.sm) {
                                Image(systemName: iconName(for: item.icon))
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(DesignSystem.Colors.ctaGreen)
                                    .frame(width: 20, alignment: .center)

                                Text(item.title)
                                    .font(DesignSystem.Fonts.valueProp)
                                    .foregroundColor(DesignSystem.Colors.textCream)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, DesignSystem.Spacing.xs)
                }
            } footerBelowCTAContent: {
                if currentStep == .intro {
                    HStack(spacing: 6) {
                        Text("Already have an account?")
                            .font(DesignSystem.Fonts.link)
                            .foregroundColor(DesignSystem.Colors.textMuted)

                        Button(action: { print("TODO: Sign in") }) {
                            Text("Sign In")
                                .font(DesignSystem.Fonts.link)
                                .foregroundColor(DesignSystem.Colors.ctaGreen)
                        }
                        .buttonStyle(.plain)
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
    }

    @ViewBuilder
    private var headerView: some View {
        Color.clear
    }

    @ViewBuilder
    private var currentStepView: some View {
        switch currentStep {
        case .intro:
            IntroView()
        case .authName:
            AuthNameView(email: $email, authProvider: $authProvider, onAuthenticated: advance)
        case .preferences:
            PreferencesView(
                selectedPreferences: $selectedPreferences,
                optimizationGoal: $optimizationGoal,
                hasSelection: $hasPreferenceSelection,
                stepIndex: $preferenceStepIndex
            )
        case .welcome:
            EmptyView()
        }
    }

    private var primaryCTATitle: String {
        if currentStep == .intro {
            return "Get Started"
        }
        return stepIndex == OnboardingStep.allCases.count - 1 ? "Start Cooking" : "Continue"
    }

    private func advance() {
        if currentStep == .preferences {
            if preferenceStepIndex < totalPreferenceSteps - 1 {
                preferenceStepIndex += 1
                return
            }
        }

        if stepIndex >= OnboardingStep.allCases.count - 1 {
            completeOnboarding()
        } else {
            stepIndex += 1
            if currentStep != .preferences {
                hasPreferenceSelection = false
            }
            if currentStep != .preferences {
                preferenceStepIndex = 0
            }
        }
    }

    private var currentStep: OnboardingStep {
        OnboardingStep(rawValue: stepIndex) ?? .intro
    }

    private func completeOnboarding() {
        storedAuthProvider = authProvider
        hasCompletedOnboarding = true
    }

    private func iconName(for symbol: String) -> String {
        if UIImage(systemName: symbol) != nil {
            return symbol
        }
        return "bolt.circle"
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
        .environmentObject(ThemeManager())
}
