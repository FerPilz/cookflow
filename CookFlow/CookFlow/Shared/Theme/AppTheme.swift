//
//  AppTheme.swift
//  CookFlow
//
//  Created by Codex on 3/17/26.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case day

    var id: String { rawValue }

    var title: String {
        switch self {
        case .day:
            return "Light"
        }
    }

    var preferredColorScheme: ColorScheme? {
        .light
    }
}
