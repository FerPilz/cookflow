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
                Circle()
                    .fill(DesignSystem.Colors.card)
                Text("CF")
                    .font(DesignSystem.Fonts.appName)
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
