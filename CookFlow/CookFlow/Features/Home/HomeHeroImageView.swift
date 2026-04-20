//
//  HomeHeroImageView.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import SwiftUI
import UIKit

struct HomeHeroImageView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            if !recipe.heroImageName.isEmpty, UIImage(named: recipe.heroImageName) != nil {
                Image(recipe.heroImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .clipped()
            } else {
                LinearGradient(
                    colors: [DesignSystem.Colors.card, DesignSystem.Colors.backgroundNearBlack],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .aspectRatio(3 / 2, contentMode: .fill)
        .background(DesignSystem.Colors.card)
    }
}

#Preview {
    HomeHeroImageView(recipe: SampleData.recipes(for: "Top Picks for You").first ?? Recipe(title: "Sample", subtitle: "Sub"))
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
