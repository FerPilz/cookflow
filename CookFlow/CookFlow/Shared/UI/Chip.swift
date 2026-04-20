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
        Button(action: onTap) {
            HStack(spacing: DesignSystem.Spacing.xs) {
                Image(systemName: systemIcon)
                    .foregroundStyle(isSelected ? DesignSystem.Colors.backgroundNearBlack : tint)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 18, height: 18)
                    .padding(7)
                    .background(iconBackground)
                    .clipShape(Circle())

                Text(title)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(isSelected ? DesignSystem.Colors.backgroundNearBlack : DesignSystem.Colors.textCream)
                    .lineLimit(1)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                        .padding(6)
                        .background(DesignSystem.Colors.selectorGreen.opacity(0.85))
                        .clipShape(Circle())
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(chipBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(chipBorderColor, lineWidth: 1)
            )
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var chipBackground: some View {
        if isSelected {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(DesignSystem.Colors.selectorGreen)
        } else {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(DesignSystem.Gradients.selectorIdle)
        }
    }

    @ViewBuilder
    private var iconBackground: some View {
        if isSelected {
            Circle()
                .fill(DesignSystem.Colors.selectorGreen.opacity(0.88))
        } else {
            Circle()
                .fill(DesignSystem.Gradients.selectorIdleIcon)
        }
    }

    private var chipBorderColor: Color {
        isSelected ? DesignSystem.Colors.selectorGreen.opacity(0.95) : DesignSystem.Colors.selectorBlueHighlight.opacity(0.28)
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
