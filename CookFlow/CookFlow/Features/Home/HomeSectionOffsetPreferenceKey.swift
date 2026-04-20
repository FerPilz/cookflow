//
//  HomeSectionOffsetPreferenceKey.swift
//  CookFlow
//
//  Created by Codex on 3/26/26.
//

import SwiftUI

struct HomeSectionOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: [String: CGFloat] = [:]

    static func reduce(value: inout [String: CGFloat], nextValue: () -> [String: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { _, new in new })
    }
}
