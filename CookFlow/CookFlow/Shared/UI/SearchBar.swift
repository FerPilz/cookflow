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
                .foregroundColor(DesignSystem.Colors.textCream.opacity(0.72))

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .foregroundColor(DesignSystem.Colors.textCream.opacity(0.72))
            )
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(.white)
                .tint(.white)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textCream.opacity(0.72))
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
                .stroke(DesignSystem.Colors.textCream.opacity(0.12), lineWidth: 1)
        )
    }
}

#Preview {
    SearchBar(text: .constant(""))
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
