//
//  AppTheme.swift
//  CookFlow
//
//  Created by Codex on 3/17/26.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case day
    case night
    case system

    var id: String { rawValue }

    var title: String {
        switch self {
        case .day:
            return "Day"
        case .night:
            return "Night"
        case .system:
            return "System"
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch self {
        case .day:
            return .light
        case .night:
            return .dark
        case .system:
            return nil
        }
    }
}
