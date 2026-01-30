//
//  SecondaryButton.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(DesignSystem.Fonts.linkText)
                .foregroundColor(DesignSystem.Colors.textCream)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
        }
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        SecondaryButton(title: "Back") {}
            .padding(DesignSystem.Spacing.lg)
    }
}
