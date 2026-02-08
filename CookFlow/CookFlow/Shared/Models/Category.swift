//
//  Category.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: UUID
    let title: String
    let systemImageName: String

    init(id: UUID = UUID(), title: String, systemImageName: String) {
        self.id = id
        self.title = title
        self.systemImageName = systemImageName
    }
}
