//
//  Recipe.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Foundation

struct Recipe: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let category: String?
    let imageURL: URL?
    let tag: String?
    let durationMinutes: Int?
    let calories: Int?
    let likes: Int?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        category: String? = nil,
        imageURL: URL? = nil,
        tag: String? = nil,
        durationMinutes: Int? = nil,
        calories: Int? = nil,
        likes: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.imageURL = imageURL
        self.tag = tag
        self.durationMinutes = durationMinutes
        self.calories = calories
        self.likes = likes
    }
}
