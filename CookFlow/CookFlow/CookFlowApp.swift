//
//  CookFlowApp.swift
//  CookFlow
//
//  Created by Fernando Pilz on 1/29/26.
//

import SwiftUI

#if canImport(GoogleSignIn)
import GoogleSignIn
#endif

@main
struct CookFlowApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    #if canImport(GoogleSignIn)
                    _ = GIDSignIn.sharedInstance.handle(url)
                    #endif
                }
        }
    }
}
