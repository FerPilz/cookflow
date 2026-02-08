//
//  DesignSystem.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

enum DesignSystem {
    enum Colors {
        static let backgroundNearBlack = Color(hex: 0x0B0B0C)
        static let textCream = Color(hex: 0xF4EFE6)
        static let textMuted = Color(hex: 0xCFC8BC)
        static let card = Color(hex: 0x141416)
        static let divider = Color(hex: 0x242428)
        static let ctaGreen = Color(hex: 0x2CCB6F)
    }

    enum Spacing {
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum Radius {
        static let standard: CGFloat = 16
    }

    enum Fonts {
        static let appName = Font.system(size: 28, weight: .semibold)
        static let heroTitle = Font.system(size: 36, weight: .semibold)
        static let screenTitle = Font.system(size: 24, weight: .semibold)
        static let body = Font.system(size: 20, weight: .regular)
        static let subtitle = Font.system(size: 16, weight: .regular)
        static let valueProp = Font.system(size: 13, weight: .medium)
        static let stepLabel = Font.system(size: 13, weight: .medium)
        static let buttonLabel = Font.system(size: 20, weight: .semibold)
        static let link = Font.system(size: 15, weight: .medium)
        static let linkText = Font.system(size: 15, weight: .medium)
    }
}

private extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self = Color(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
