//
//  IntroView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

struct IntroView: View {
    var body: some View {
        let proteinSymbol = UIImage(systemName: "figure.strengthtraining.traditional") != nil
            ? "figure.strengthtraining.traditional"
            : "dumbbell"

        VStack(spacing: DesignSystem.Spacing.lg) {
            VStack(spacing: DesignSystem.Spacing.sm) {
                Text("CookFlow")
                    .font(DesignSystem.Fonts.heroTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .multilineTextAlignment(.center)

                Text("Recipes tailored to your goals in 30 seconds.")
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .multilineTextAlignment(.center)
            }

            HStack(spacing: DesignSystem.Spacing.lg) {
                ValuePropItem(systemName: "person.crop.circle.badge.checkmark", title: "Personalized picks")
                ValuePropItem(systemName: proteinSymbol, title: "Protein & nutrition")
                ValuePropItem(systemName: "calendar", title: "Fast meal planning")
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    IntroView()
        .preferredColorScheme(.dark)
}
