//
//  AppLogoView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

struct AppLogoView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = min(proxy.size.height * 0.70, proxy.size.width * 0.28)
            ZStack {
                if let uiImage = UIImage(named: "AppLogo") {
                    Image(uiImage: uiImage)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .accessibilityLabel("CookFlow")
    }
}

#Preview {
    ZStack {
        DesignSystem.Colors.backgroundNearBlack
        AppLogoView()
            .frame(height: 220)
    }
}
