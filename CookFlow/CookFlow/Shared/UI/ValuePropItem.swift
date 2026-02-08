//
//  ValuePropItem.swift
//  CookFlow
//
//  Created by Codex on 2/3/26.
//

import SwiftUI

struct ValuePropItem: View {
    let systemName: String
    let title: String

    init(systemName: String, title: String) {
        self.systemName = systemName
        self.title = title
    }

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.xs) {
            Image(systemName: systemName)
                .foregroundStyle(DesignSystem.Colors.textCream)
                .font(.system(size: 24, weight: .semibold))
                .frame(height: 26)

            Text(title)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textCream)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        HStack(spacing: DesignSystem.Spacing.lg) {
            ValuePropItem(systemName: "sparkles", title: "Personalized picks")
            ValuePropItem(systemName: "bolt.heart", title: "Protein & nutrition")
            ValuePropItem(systemName: "calendar", title: "Fast meal planning")
        }
        .padding(DesignSystem.Spacing.lg)
    }
}
