//
//  IntroView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

struct IntroView: View {
    private var versionLabel: String {
        "CookFlow 1.0"
    }

    var body: some View {
        ZStack(alignment: .top) {
            Text(versionLabel)
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
                .padding(.top, DesignSystem.Spacing.lg)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    IntroView()
        .preferredColorScheme(.dark)
}
