//
//  FavoritesStore.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import Combine
import Foundation

final class FavoritesStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<String> = [] {
        didSet {
            persist()
        }
    }

    private let storageKey = "favoriteRecipeIDs"

    init() {
        load()
    }

    func isFavorite(id: String) -> Bool {
        favoriteIDs.contains(id)
    }

    func toggle(id: String) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
    }

    func setFavorite(id: String, isFavorite: Bool) {
        if isFavorite {
            favoriteIDs.insert(id)
        } else {
            favoriteIDs.remove(id)
        }
    }

    var favoritesByCategory: [String: [Recipe]] {
        let favorites = SampleData.allRecipes.filter { favoriteIDs.contains($0.id) }
        return Dictionary(grouping: favorites, by: { $0.category })
    }

    private func persist() {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: storageKey)
    }

    private func load() {
        guard let stored = UserDefaults.standard.array(forKey: storageKey) as? [String] else { return }
        favoriteIDs = Set(stored)
    }
}
