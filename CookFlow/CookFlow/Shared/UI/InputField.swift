//
//  InputField.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct InputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text(label)
                .font(DesignSystem.Fonts.stepLabel)
                .foregroundColor(DesignSystem.Colors.textMuted)

            TextField(placeholder, text: $text)
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textCream)
                .padding(DesignSystem.Spacing.md)
                .background(DesignSystem.Colors.card)
                .cornerRadius(DesignSystem.Radius.standard)
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.standard)
                        .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                )
        }
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        InputField(label: "Name", placeholder: "Your name", text: .constant(""))
            .padding(DesignSystem.Spacing.lg)
    }
}
