//
//  ShoppingExportProvider.swift
//  CookFlow
//
//  Created by Codex on 3/25/26.
//

import Foundation

enum ShoppingExportDestination: String, CaseIterable {
    case instacart
}

struct ShoppingExportLineItem: Hashable {
    let name: String
    let quantity: Double?
    let unit: String?
    let category: String?
    let sourceRecipes: [ShoppingItemSource]
}

struct ShoppingExportPayload: Hashable {
    let destination: ShoppingExportDestination
    let items: [ShoppingExportLineItem]
}

protocol ShoppingExportProviding {
    var destination: ShoppingExportDestination { get }
    func makePayload(from items: [ShoppingItem]) -> ShoppingExportPayload
}

struct InstacartExportProvider: ShoppingExportProviding {
    let destination: ShoppingExportDestination = .instacart

    func makePayload(from items: [ShoppingItem]) -> ShoppingExportPayload {
        let exportItems = items.map { item in
            ShoppingExportLineItem(
                name: item.name,
                quantity: item.quantity,
                unit: item.unit,
                category: item.category,
                sourceRecipes: item.sourceRecipes
            )
        }

        return ShoppingExportPayload(destination: destination, items: exportItems)
    }
}
