//
//  HomeStickyHeaderView.swift
//  CookFlow
//
//  Created by Codex on 2/11/26.
//

import SwiftUI

struct HomeStickyHeaderView: View {
    static let baseHeight: CGFloat = 84

    let topInset: CGFloat
    let categories: [Category]
    let selectedCategoryTitle: String
    let onSelectCategory: (Category) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignSystem.Spacing.sm) {
                    ForEach(categories) { category in
                        categoryButton(category)
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
            }
            .padding(.top, topInset + 3)
            .padding(.bottom, 6)
            .frame(height: HomeStickyHeaderView.baseHeight + topInset, alignment: .bottom)
            .background(DesignSystem.Colors.topBarBackground.opacity(0.96))

            Rectangle()
                .fill(DesignSystem.Colors.divider)
                .frame(height: 1)
        }
    }

    private func categoryButton(_ category: Category) -> some View {
        let isSelected = selectedCategoryTitle == category.title

        return Button(action: { onSelectCategory(category) }) {
            VStack(spacing: 6) {
                Image(systemName: category.mappedSymbolName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isSelected ? DesignSystem.Colors.selectorBlueHighlight : DesignSystem.Colors.textCream)
                    .frame(width: 15, height: 15)
                    .contentShape(Rectangle())

                Text(category.title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(isSelected ? DesignSystem.Colors.selectorBlueHighlight : DesignSystem.Colors.textCream)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 108)
            .padding(.vertical, DesignSystem.Spacing.xs)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeStickyHeaderView(
        topInset: 0,
        categories: SampleData.topLevelSearchCategories(includeMyRecipes: true),
        selectedCategoryTitle: SampleData.topLevelSearchCategories(includeMyRecipes: true).first?.title ?? "",
        onSelectCategory: { _ in }
    )
    .preferredColorScheme(.dark)
}
