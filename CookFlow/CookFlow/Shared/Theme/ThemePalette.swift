//
//  ThemePalette.swift
//  CookFlow
//
//  Created by Codex on 3/17/26.
//

import SwiftUI
import UIKit

struct ThemePalette {
    let backgroundHex: UInt32
    let secondaryBackgroundHex: UInt32
    let cardBackgroundHex: UInt32
    let primaryTextHex: UInt32
    let secondaryTextHex: UInt32
    let tertiaryTextHex: UInt32
    let accentHex: UInt32
    let borderHex: UInt32
    let topBarBackgroundHex: UInt32
    let tabBarBackgroundHex: UInt32
    let onAccentTextHex: UInt32

    var background: Color { Color(themeHex: backgroundHex) }
    var secondaryBackground: Color { Color(themeHex: secondaryBackgroundHex) }
    var cardBackground: Color { Color(themeHex: cardBackgroundHex) }
    var primaryText: Color { Color(themeHex: primaryTextHex) }
    var secondaryText: Color { Color(themeHex: secondaryTextHex) }
    var tertiaryText: Color { Color(themeHex: tertiaryTextHex) }
    var accent: Color { Color(themeHex: accentHex) }
    var border: Color { Color(themeHex: borderHex) }
    var topBarBackground: Color { Color(themeHex: topBarBackgroundHex) }
    var tabBarBackground: Color { Color(themeHex: tabBarBackgroundHex) }
    var onAccentText: Color { Color(themeHex: onAccentTextHex) }

    static let day = ThemePalette(
        backgroundHex: 0xF7F2E8,
        secondaryBackgroundHex: 0xEFE7DA,
        cardBackgroundHex: 0xFFFBF4,
        primaryTextHex: 0x171411,
        secondaryTextHex: 0x655C52,
        tertiaryTextHex: 0x94897B,
        accentHex: 0x2CCB6F,
        borderHex: 0xDCD2C2,
        topBarBackgroundHex: 0xFBF6EE,
        tabBarBackgroundHex: 0xFBF6EE,
        onAccentTextHex: 0x0B0B0C
    )

    static func palette(for colorScheme: ColorScheme) -> ThemePalette {
        .day
    }

    static func palette(for interfaceStyle: UIUserInterfaceStyle) -> ThemePalette {
        .day
    }
}

extension Color {
    init(themeHex: UInt32) {
        let red = Double((themeHex >> 16) & 0xFF) / 255.0
        let green = Double((themeHex >> 8) & 0xFF) / 255.0
        let blue = Double(themeHex & 0xFF) / 255.0
        self = Color(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}

extension UIColor {
    convenience init(themeHex: UInt32) {
        let red = CGFloat((themeHex >> 16) & 0xFF) / 255.0
        let green = CGFloat((themeHex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(themeHex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
