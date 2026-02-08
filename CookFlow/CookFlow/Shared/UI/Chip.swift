//
//  Chip.swift
//  CookFlow
//
//  Created by Codex on 2/3/26.
//

import SwiftUI

struct Chip: View {
    let title: String
    let systemIcon: String
    let tint: Color
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        let iconPrimary = DesignSystem.Colors.textCream

        Button(action: onTap) {
            HStack(spacing: DesignSystem.Spacing.xs) {
                Text(title)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .lineLimit(1)

                Image(systemName: systemIcon)
                    .foregroundStyle(iconPrimary)
                    .font(.system(size: 16, weight: .semibold))

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .padding(6)
                        .background(DesignSystem.Colors.ctaGreen)
                        .clipShape(Circle())
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isSelected ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.card)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? DesignSystem.Colors.ctaGreen.opacity(0.9) : DesignSystem.Colors.divider, lineWidth: 1)
            )
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        VStack(spacing: DesignSystem.Spacing.sm) {
            Chip(title: "Vegetarian", systemIcon: "leaf.fill", tint: .green, isSelected: false) {}
            Chip(title: "Protein", systemIcon: "dumbbell", tint: .orange, isSelected: true) {}
        }
        .padding(DesignSystem.Spacing.lg)
    }
}
