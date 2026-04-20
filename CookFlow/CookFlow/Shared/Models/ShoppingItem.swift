//
//  ShoppingItem.swift
//  CookFlow
//
//  Created by Codex on 3/24/26.
//

import Foundation

struct ShoppingItemSource: Codable, Hashable, Identifiable {
    let recipeID: String
    let recipeTitle: String

    var id: String { recipeID }
}

struct ShoppingItem: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String {
        didSet {
            normalizedName = Self.normalize(name)
        }
    }
    var normalizedName: String
    var quantity: Double?
    var unit: String?
    var isChecked: Bool
    var sourceRecipes: [ShoppingItemSource]
    var category: String?
    var isManualItem: Bool

    init(
        id: UUID = UUID(),
        name: String,
        quantity: Double? = nil,
        unit: String? = nil,
        isChecked: Bool = false,
        sourceRecipes: [ShoppingItemSource] = [],
        category: String? = nil,
        isManualItem: Bool = false
    ) {
        self.id = id
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.normalizedName = Self.normalize(name)
        self.quantity = quantity
        self.unit = unit?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.isChecked = isChecked
        self.sourceRecipes = sourceRecipes
        self.category = category?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.isManualItem = isManualItem
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case normalizedName
        case quantity
        case unit
        case isChecked
        case sourceRecipes
        case category
        case isManualItem

        // Legacy keys
        case quantityText
        case place
        case sourceRecipeID
        case sourceRecipeTitle
        case recipeID
        case recipeTitle
        case ingredientName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        let decodedName = try container.decodeIfPresent(String.self, forKey: .name)
            ?? container.decodeIfPresent(String.self, forKey: .ingredientName)
            ?? ""
        name = decodedName.trimmingCharacters(in: .whitespacesAndNewlines)
        normalizedName = try container.decodeIfPresent(String.self, forKey: .normalizedName) ?? Self.normalize(decodedName)
        isChecked = try container.decodeIfPresent(Bool.self, forKey: .isChecked) ?? false
        unit = try container.decodeIfPresent(String.self, forKey: .unit)
        category = try container.decodeIfPresent(String.self, forKey: .category)
            ?? container.decodeIfPresent(String.self, forKey: .place)

        if let decodedSources = try container.decodeIfPresent([ShoppingItemSource].self, forKey: .sourceRecipes) {
            sourceRecipes = decodedSources
        } else if let recipeID = try container.decodeIfPresent(String.self, forKey: .sourceRecipeID)
            ?? container.decodeIfPresent(String.self, forKey: .recipeID),
            let recipeTitle = try container.decodeIfPresent(String.self, forKey: .sourceRecipeTitle)
            ?? container.decodeIfPresent(String.self, forKey: .recipeTitle) {
            sourceRecipes = [ShoppingItemSource(recipeID: recipeID, recipeTitle: recipeTitle)]
        } else {
            sourceRecipes = []
        }

        if let quantity = try container.decodeIfPresent(Double.self, forKey: .quantity) {
            self.quantity = quantity
        } else if let intQuantity = try container.decodeIfPresent(Int.self, forKey: .quantity) {
            self.quantity = Double(intQuantity)
        } else if let legacyQuantityText = try container.decodeIfPresent(String.self, forKey: .quantityText) {
            self.quantity = Self.parseQuantity(legacyQuantityText)
        } else {
            self.quantity = nil
        }

        isManualItem = try container.decodeIfPresent(Bool.self, forKey: .isManualItem) ?? sourceRecipes.isEmpty
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(normalizedName, forKey: .normalizedName)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(cleaned(unit), forKey: .unit)
        try container.encode(isChecked, forKey: .isChecked)
        try container.encode(sourceRecipes, forKey: .sourceRecipes)
        try container.encodeIfPresent(cleaned(category), forKey: .category)
        try container.encode(isManualItem, forKey: .isManualItem)
    }

    var displayQuantityUnit: String? {
        guard let quantity else {
            return cleaned(unit)
        }

        let numberText: String
        if quantity.rounded() == quantity {
            numberText = String(Int(quantity))
        } else {
            numberText = String(format: "%.1f", quantity)
        }

        if let unit = cleaned(unit) {
            return "\(numberText) \(unit)"
        }

        return numberText
    }

    var displaySource: String? {
        if sourceRecipes.count == 1 {
            return sourceRecipes.first?.recipeTitle
        }

        if sourceRecipes.count > 1 {
            return "\(sourceRecipes.count) recipes"
        }

        return nil
    }

    var resolvedCategory: String {
        cleaned(category) ?? "Other"
    }

    var mergeKey: String {
        "\(normalizedName)|\(cleaned(unit)?.lowercased() ?? "")|manual:\(isManualItem)"
    }

    static func normalize(_ name: String) -> String {
        name
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

    static func parseQuantity(_ raw: String) -> Double? {
        let cleaned = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")

        if let direct = Double(cleaned) {
            return direct
        }

        let parts = cleaned.split(separator: "/")
        if parts.count == 2,
           let numerator = Double(parts[0]),
           let denominator = Double(parts[1]),
           denominator != 0 {
            return numerator / denominator
        }

        return nil
    }

    func merged(with other: ShoppingItem) -> ShoppingItem? {
        guard normalizedName == other.normalizedName else { return nil }
        guard cleaned(unit)?.lowercased() == other.cleaned(other.unit)?.lowercased() else { return nil }
        guard isManualItem == other.isManualItem else { return nil }

        var mergedItem = self
        mergedItem.isChecked = isChecked && other.isChecked

        if let quantity, let otherQuantity = other.quantity {
            mergedItem.quantity = quantity + otherQuantity
        } else if quantity == nil && other.quantity == nil {
            mergedItem.quantity = nil
        } else {
            mergedItem.quantity = nil
        }

        if cleaned(category) == nil {
            mergedItem.category = other.category
        }

        if !isManualItem {
            let combinedSources = sourceRecipes + other.sourceRecipes
            var seen = Set<String>()
            mergedItem.sourceRecipes = combinedSources.filter { source in
                guard !seen.contains(source.recipeID) else { return false }
                seen.insert(source.recipeID)
                return true
            }
        }

        return mergedItem
    }

    func updatingFromSuggestion(_ suggestion: ShoppingItemSuggestion) -> ShoppingItem {
        ShoppingItem(
            id: id,
            name: suggestion.name,
            quantity: quantity,
            unit: unit ?? suggestion.unit,
            isChecked: isChecked,
            sourceRecipes: sourceRecipes,
            category: category ?? suggestion.category,
            isManualItem: isManualItem
        )
    }

    private func cleaned(_ value: String?) -> String? {
        guard let value else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}

struct ShoppingItemGroup: Identifiable, Hashable {
    let title: String
    let items: [ShoppingItem]

    var id: String { title }
}
