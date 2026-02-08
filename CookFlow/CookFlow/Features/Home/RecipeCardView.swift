//
//  RecipeCardView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let width: CGFloat?
    let height: CGFloat
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    init(
        recipe: Recipe,
        width: CGFloat? = 200,
        height: CGFloat = 160,
        isFavorite: Bool = false,
        onToggleFavorite: @escaping () -> Void = {}
    ) {
        self.recipe = recipe
        self.width = width
        self.height = height
        self.isFavorite = isFavorite
        self.onToggleFavorite = onToggleFavorite
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            ZStack(alignment: .topTrailing) {
                imageLayer
                    .frame(height: height)
                    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))

                Button(action: onToggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(width: 44, height: 44)
                        .background(Color.black.opacity(0.35))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(8)
            }

            Text(recipe.title)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .lineLimit(2)

            Text(recipe.subtitle)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .lineLimit(1)

            if let metadata = metadataText {
                Text(metadata)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textCream)
            }
        }
        .frame(width: width)
    }

    private var metadataText: String? {
        var parts: [String] = []
        if let duration = recipe.durationMinutes {
            parts.append("\(duration)m")
        }
        if let likes = recipe.likes {
            parts.append("\(likes) likes")
        }
        return parts.isEmpty ? nil : parts.joined(separator: " · ")
    }

    @ViewBuilder
    private var imageLayer: some View {
        if let url = recipe.imageURL {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        LinearGradient(
            colors: [DesignSystem.Colors.card, DesignSystem.Colors.backgroundNearBlack],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    RecipeCardView(recipe: SampleData.recipes(for: "Top Picks for You").first ?? Recipe(title: "Sample", subtitle: "Subtitle"))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
