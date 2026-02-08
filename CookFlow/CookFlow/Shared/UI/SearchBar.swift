//
//  SearchBar.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String

    init(text: Binding<String>, placeholder: String = "Search recipes") {
        self._text = text
        self.placeholder = placeholder
    }

    var body: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textMuted)

            TextField(placeholder, text: $text)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.md)
        .padding(.vertical, 12)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview {
    SearchBar(text: .constant(""))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
