//
//  DesignSystem.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

enum DesignSystem {
    enum Colors {
        static var background: Color { ThemeRegistry.palette.background }
        static var secondaryBackground: Color { ThemeRegistry.palette.secondaryBackground }
        static var cardBackground: Color { ThemeRegistry.palette.cardBackground }
        static var primaryText: Color { ThemeRegistry.palette.primaryText }
        static var secondaryText: Color { ThemeRegistry.palette.secondaryText }
        static var tertiaryText: Color { ThemeRegistry.palette.tertiaryText }
        static var accent: Color { ThemeRegistry.palette.accent }
        static var border: Color { ThemeRegistry.palette.border }
        static var topBarBackground: Color { ThemeRegistry.palette.topBarBackground }
        static var tabBarBackground: Color { ThemeRegistry.palette.tabBarBackground }

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
        static let plannerRowMonday = Color(red: 0.25, green: 0.25, blue: 0.27)
        static let plannerRowTuesday = Color(red: 0.22, green: 0.22, blue: 0.24)
        static let plannerRowWednesday = Color(red: 0.20, green: 0.20, blue: 0.22)
        static let plannerRowThursday = Color(red: 0.18, green: 0.18, blue: 0.20)
        static let plannerRowFriday = Color(red: 0.16, green: 0.16, blue: 0.18)
        static let plannerRowSaturday = Color(red: 0.14, green: 0.14, blue: 0.16)
        static let plannerRowSunday = Color(red: 0.12, green: 0.12, blue: 0.14)
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
