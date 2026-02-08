//
//  FavoritesStore.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Foundation
import SwiftUI

final class FavoritesStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<UUID> = [] {
        didSet {
            persist()
        }
    }

    private let storageKey = "favoriteRecipeIDs"

    init() {
        load()
    }

    func isFavorite(_ id: UUID) -> Bool {
        favoriteIDs.contains(id)
    }

    func toggle(_ recipe: Recipe) {
        if favoriteIDs.contains(recipe.id) {
            favoriteIDs.remove(recipe.id)
        } else {
            favoriteIDs.insert(recipe.id)
        }
    }

    var favoritesByCategory: [String: [Recipe]] {
        let favorites = SampleData.allRecipes.filter { favoriteIDs.contains($0.id) }
        return Dictionary(grouping: favorites, by: { $0.category ?? "Other" })
    }

    private func persist() {
        let ids = favoriteIDs.map { $0.uuidString }
        UserDefaults.standard.set(ids, forKey: storageKey)
    }

    private func load() {
        guard let stored = UserDefaults.standard.array(forKey: storageKey) as? [String] else { return }
        let ids = stored.compactMap { UUID(uuidString: $0) }
        favoriteIDs = Set(ids)
    }
}
