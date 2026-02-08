//
//  RecipeDetailView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @AppStorage("isPro") private var isPro = false
    @State private var showPaywall = false

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            VStack(spacing: DesignSystem.Spacing.md) {
                Text(recipe.title)
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .multilineTextAlignment(.center)

                if let metadata = metadataText {
                    Text(metadata)
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }

                Text(recipe.subtitle)
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .multilineTextAlignment(.center)

                Text("Recipe details and instructions go here.")
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, DesignSystem.Spacing.xl)

            if !isPro {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                VStack(spacing: DesignSystem.Spacing.md) {
                    Text("Unlock full recipe access")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    PrimaryButton(title: "Unlock with CookFlow Pro") {
                        showPaywall = true
                    }
                    .padding(.horizontal, DesignSystem.Spacing.lg)
                }
            }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
    }

    private var metadataText: String? {
        var parts: [String] = []
        if let duration = recipe.durationMinutes {
            parts.append("\(duration)m")
        }
        if let tag = recipe.tag {
            parts.append(tag)
        }
        if let likes = recipe.likes {
            parts.append("\(likes) likes")
        }
        return parts.isEmpty ? nil : parts.joined(separator: " · ")
    }
}

#Preview {
    RecipeDetailView(recipe: SampleData.recipes(for: "Top Picks for You").first ?? Recipe(title: "Miso Salmon Bowl", subtitle: "Savory glaze"))
        .preferredColorScheme(.dark)
}
