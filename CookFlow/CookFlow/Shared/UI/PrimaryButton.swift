//
//  PrimaryButton.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(DesignSystem.Fonts.buttonLabel)
                .foregroundColor(DesignSystem.Colors.textCream)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
        }
        .background(isEnabled ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.divider)
        .cornerRadius(DesignSystem.Radius.standard)
        .disabled(!isEnabled)
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        PrimaryButton(title: "Continue") {}
            .padding(DesignSystem.Spacing.lg)
    }
}
