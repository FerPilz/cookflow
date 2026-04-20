//
//  ThemePalette.swift
//  CookFlow
//
//  Created by Codex on 3/17/26.
//

import SwiftUI

struct ThemePalette {
    let background: Color
    let secondaryBackground: Color
    let cardBackground: Color
    let primaryText: Color
    let secondaryText: Color
    let tertiaryText: Color
    let accent: Color
    let border: Color
    let topBarBackground: Color
    let tabBarBackground: Color

    static let day = ThemePalette(
        background: Color(themeHex: 0xF5F1E8),
        secondaryBackground: Color(themeHex: 0xECE4D6),
        cardBackground: Color(themeHex: 0xFFFCF7),
        primaryText: Color(themeHex: 0x251F18),
        secondaryText: Color(themeHex: 0x6D6357),
        tertiaryText: Color(themeHex: 0x978B7C),
        accent: Color(themeHex: 0x2CCB6F),
        border: Color(themeHex: 0xD9D0C0),
        topBarBackground: Color(themeHex: 0xF8F4EC),
        tabBarBackground: Color(themeHex: 0xF8F4EC)
    )

    static let night = ThemePalette(
        background: Color(themeHex: 0x0B0B0C),
        secondaryBackground: Color(themeHex: 0x111214),
        cardBackground: Color(themeHex: 0x141416),
        primaryText: Color(themeHex: 0xF2EBDD),
        secondaryText: Color(themeHex: 0xD3C8B8),
        tertiaryText: Color(themeHex: 0xA59A8C),
        accent: Color(themeHex: 0x2CCB6F),
        border: Color(themeHex: 0x242428),
        topBarBackground: Color(themeHex: 0x0E0E10),
        tabBarBackground: Color(themeHex: 0x0E0E10)
    )
}

extension Color {
    init(themeHex: UInt32) {
        let red = Double((themeHex >> 16) & 0xFF) / 255.0
        let green = Double((themeHex >> 8) & 0xFF) / 255.0
        let blue = Double(themeHex & 0xFF) / 255.0
        self = Color(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
