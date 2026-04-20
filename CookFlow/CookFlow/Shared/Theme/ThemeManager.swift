//
//  ThemeManager.swift
//  CookFlow
//
//  Created by Codex on 3/17/26.
//

import SwiftUI
import Combine

enum ThemeRegistry {
    static var palette: ThemePalette = .night
}

final class ThemeManager: ObservableObject {
    private enum StorageKey {
        static let selectedTheme = "selectedAppTheme"
    }

    @Published var selectedTheme: AppTheme {
        didSet {
            ThemeRegistry.palette = palette
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: StorageKey.selectedTheme)
        }
    }

    @Published private var systemColorScheme: ColorScheme = .dark

    var palette: ThemePalette {
        switch selectedTheme {
        case .day:
            return .day
        case .night:
            return .night
        case .system:
            return systemColorScheme == .dark ? .night : .day
        }
    }

    var preferredColorScheme: ColorScheme? {
        selectedTheme.preferredColorScheme
    }

    init() {
        let storedTheme = UserDefaults.standard.string(forKey: StorageKey.selectedTheme)
            .flatMap(AppTheme.init(rawValue:))
            ?? .night
        selectedTheme = storedTheme
        ThemeRegistry.palette = palette
    }

    init(theme colorScheme: ColorScheme) {
        selectedTheme = colorScheme == .dark ? .night : .day
        systemColorScheme = colorScheme
        ThemeRegistry.palette = palette
    }

    func updateSystemColorScheme(_ colorScheme: ColorScheme) {
        guard systemColorScheme != colorScheme else { return }
        systemColorScheme = colorScheme
        ThemeRegistry.palette = palette
    }
}
