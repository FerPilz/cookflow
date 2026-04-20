//
//  CookFlowApp.swift
//  CookFlow
//
//  Created by Fernando Pilz on 1/29/26.
//

import SwiftUI
import SwiftData

#if canImport(GoogleSignIn)
import GoogleSignIn
#endif

@main
struct CookFlowApp: App {
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.preferredColorScheme)
                .onOpenURL { url in
                    #if canImport(GoogleSignIn)
                    _ = GIDSignIn.sharedInstance.handle(url)
                    #endif
                }
        }
        .modelContainer(for: [Recipe.self])
    }
}
