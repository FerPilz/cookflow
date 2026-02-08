//
//  CategoryCardView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category

    var body: some View {
        Button(action: {}) {
            VStack(spacing: DesignSystem.Spacing.xs) {
                Image(systemName: category.systemImageName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textCream)

                Text(category.title)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignSystem.Spacing.sm)
            .padding(.horizontal, DesignSystem.Spacing.xs)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(category.title)
    }
}

#Preview {
    CategoryCardView(category: Category(title: "Breakfast", systemImageName: "sunrise.fill"))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
