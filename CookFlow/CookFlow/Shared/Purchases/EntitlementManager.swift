//
//  EntitlementManager.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import Combine
import SwiftUI

@MainActor
final class EntitlementManager: ObservableObject {
    @AppStorage("isPro") private var storedIsPro: Bool = false
    @Published var hasPro: Bool = false

    init() {
        hasPro = storedIsPro
    }

    func setPro(_ value: Bool) {
        storedIsPro = value
        hasPro = value
    }
}
