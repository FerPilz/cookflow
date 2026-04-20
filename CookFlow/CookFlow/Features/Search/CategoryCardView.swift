//
//  CategoryCardView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category
    let thumbnailImageName: String?

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            CategoryThumbnailView(
                imageName: thumbnailImageName,
                size: 85,
                systemImageName: category.mappedSymbolName,
                presentation: .circle
            )
                .frame(maxWidth: .infinity, alignment: .center)

            Text(displayTitle)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(DesignSystem.Colors.textCream)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .allowsTightening(true)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, DesignSystem.Spacing.xs)
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .accessibilityLabel(displayTitle)
    }

    private var displayTitle: String {
        category.title == "Drinks" ? "Cocktails" : category.title
    }
}

#Preview {
    CategoryCardView(category: Category(title: "Breakfast", systemImageName: "sunrise.fill"), thumbnailImageName: nil)
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
