//
//  ThemeManager.swift
//  CookFlow
//
//  Created by Codex on 3/17/26.
//

import SwiftUI
import Combine

final class ThemeManager: ObservableObject {
    private enum StorageKey {
        static let selectedTheme = "selectedAppTheme"
    }

    @Published var selectedTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: StorageKey.selectedTheme)
        }
    }

    @Published private var systemColorScheme: ColorScheme = .light

    var palette: ThemePalette {
        .day
    }

    var preferredColorScheme: ColorScheme? {
        .light
    }

    init() {
        selectedTheme = .day
        UserDefaults.standard.set(AppTheme.day.rawValue, forKey: StorageKey.selectedTheme)
    }

    init(theme colorScheme: ColorScheme) {
        selectedTheme = .day
        systemColorScheme = .light
    }

    func updateSystemColorScheme(_ colorScheme: ColorScheme) {
        systemColorScheme = .light
    }
}
