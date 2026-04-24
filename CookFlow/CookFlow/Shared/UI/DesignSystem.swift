//
//  DesignSystem.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

enum DesignSystem {
    enum Colors {
        static var background: Color { dynamicColor(\.backgroundHex) }
        static var secondaryBackground: Color { dynamicColor(\.secondaryBackgroundHex) }
        static var cardBackground: Color { dynamicColor(\.cardBackgroundHex) }
        static var primaryText: Color { dynamicColor(\.primaryTextHex) }
        static var secondaryText: Color { dynamicColor(\.secondaryTextHex) }
        static var tertiaryText: Color { dynamicColor(\.tertiaryTextHex) }
        static var accent: Color { dynamicColor(\.accentHex) }
        static var border: Color { dynamicColor(\.borderHex) }
        static var topBarBackground: Color { dynamicColor(\.topBarBackgroundHex) }
        static var tabBarBackground: Color { dynamicColor(\.tabBarBackgroundHex) }
        static var onAccentText: Color { dynamicColor(\.onAccentTextHex) }

        static var backgroundNearBlack: Color { background }
        static var textCream: Color { primaryText }
        static var textMuted: Color { secondaryText }
        static var textTertiary: Color { tertiaryText }
        static var card: Color { cardBackground }
        static var divider: Color { border }
        static var ctaGreen: Color { accent }
        static let selectorGreen = Color(red: 0.51, green: 0.89, blue: 0.31)
        static let selectorBlueStart = Color(red: 0.30, green: 0.49, blue: 0.73)
        static let selectorBlueEnd = Color(red: 0.17, green: 0.25, blue: 0.38)
        static let selectorBlueHighlight = Color(red: 0.45, green: 0.71, blue: 0.97)
        static let plannerSelectionBlue = Color(red: 0.33, green: 0.61, blue: 0.96)
        static let plannerCaloriesRed = Color(red: 0.92, green: 0.35, blue: 0.33)
        static var plannerRowMonday: Color { dynamicColor(light: 0xF1E9DC, dark: 0x403F45) }
        static var plannerRowTuesday: Color { dynamicColor(light: 0xEEE4D4, dark: 0x38383D) }
        static var plannerRowWednesday: Color { dynamicColor(light: 0xECE1D0, dark: 0x333338) }
        static var plannerRowThursday: Color { dynamicColor(light: 0xE9DECC, dark: 0x2E2E33) }
        static var plannerRowFriday: Color { dynamicColor(light: 0xE7DBC8, dark: 0x29292E) }
        static var plannerRowSaturday: Color { dynamicColor(light: 0xE4D8C3, dark: 0x252529) }
        static var plannerRowSunday: Color { dynamicColor(light: 0xE1D4BE, dark: 0x212125) }

        private static func dynamicColor(_ keyPath: KeyPath<ThemePalette, UInt32>) -> Color {
            Color(
                uiColor: UIColor { traits in
                    UIColor(themeHex: ThemePalette.palette(for: traits.userInterfaceStyle)[keyPath: keyPath])
                }
            )
        }

        private static func dynamicColor(light: UInt32, dark: UInt32) -> Color {
            Color(
                uiColor: UIColor { traits in
                    UIColor(themeHex: traits.userInterfaceStyle == .dark ? dark : light)
                }
            )
        }
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
        static let imageCard: CGFloat = 18
        static let selectorIcon: CGFloat = 22
    }

    enum Gradients {
        static let selectorIdle = LinearGradient(
            colors: [
                Colors.selectorBlueStart.opacity(0.28),
                Colors.selectorBlueEnd.opacity(0.84)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        static let selectorIdleIcon = LinearGradient(
            colors: [
                Colors.selectorBlueHighlight.opacity(0.92),
                Colors.selectorBlueStart.opacity(0.9)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        static let imageFallback = LinearGradient(
            colors: [
                Colors.card.opacity(0.96),
                Colors.selectorBlueEnd.opacity(0.92)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
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
