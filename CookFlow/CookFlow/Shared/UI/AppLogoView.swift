//
//  AppLogoView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

struct AppLogoView: View {
    let size: CGFloat

    init(size: CGFloat = 140) {
        self.size = size
    }

    var body: some View {
        ZStack {
            if UIImage(named: "AppLogo") != nil {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
            } else {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .fill(DesignSystem.Colors.card)
                Image(systemName: "fork.knife")
                    .font(.system(size: size * 0.32, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textCream)
            }
        }
        .frame(width: size, height: size)
        .accessibilityLabel("CookFlow")
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        AppLogoView()
    }
}
