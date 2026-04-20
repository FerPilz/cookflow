import Foundation
import Combine

typealias ShoppingListItem = ShoppingItem

struct ShoppingList: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var items: [ShoppingListItem]
    var updatedAt: Date
    var createdAt: Date

    init(id: UUID = UUID(), name: String, items: [ShoppingListItem], updatedAt: Date = Date(), createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.items = items
        self.updatedAt = updatedAt
        self.createdAt = createdAt
    }

    var groupedItems: [ShoppingItemGroup] {
        let grouped = Dictionary(grouping: items, by: \.resolvedCategory)

        return grouped
            .map { title, items in
                ShoppingItemGroup(
                    title: title,
                    items: items.sorted {
                        $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
                    }
                )
            }
            .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    }
}

@MainActor
final class ShoppingListStore: ObservableObject {
    @Published private(set) var lists: [ShoppingList] = []

    private let storageKey = "cookflow.shoppingLists.v2"
    private let legacyStorageKey = "cookflow.shoppingLists.v1"

    init() {
        load()
    }

    func addList(name: String, items: [ShoppingListItem]) {
        _ = createList(name: name, items: items)
    }

    func createList(name: String, items: [ShoppingListItem]) -> ShoppingList {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let listName = trimmedName.isEmpty ? "Shopping List" : trimmedName
        let newList = ShoppingList(name: listName, items: items, updatedAt: Date(), createdAt: Date())
        lists.insert(newList, at: 0)
        persist()
        return newList
    }

    func updateList(id: UUID, name: String, items: [ShoppingListItem]) {
        guard let index = lists.firstIndex(where: { $0.id == id }) else { return }
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        lists[index].name = trimmedName.isEmpty ? "Shopping List" : trimmedName
        lists[index].items = items
        lists[index].updatedAt = Date()
        persist()
    }

    func updateList(_ list: ShoppingList) {
        guard let index = lists.firstIndex(where: { $0.id == list.id }) else { return }
        var updated = list
        updated.updatedAt = Date()
        lists[index] = updated
        persist()
    }

    func deleteList(id: UUID) {
        lists.removeAll { $0.id == id }
        persist()
    }

    func toggleItem(listID: UUID, itemID: UUID) {
        guard let listIndex = listIndex(for: listID),
              let itemIndex = itemIndex(in: listIndex, itemID: itemID) else { return }
        lists[listIndex].items[itemIndex].isChecked.toggle()
        touch(listIndex)
    }

    func addItem(listID: UUID, name: String, quantity: Double?, unit: String? = nil, category: String? = nil) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, let listIndex = listIndex(for: listID) else { return }

        lists[listIndex].items.append(
            ShoppingListItem(
                name: trimmed,
                quantity: quantity,
                unit: unit,
                isChecked: false,
                sourceRecipes: [],
                category: category,
                isManualItem: true
            )
        )
        touch(listIndex)
    }

    func addItem(to listID: UUID, item: ShoppingListItem) {
        guard let listIndex = listIndex(for: listID) else { return }
        lists[listIndex].items.append(item)
        touch(listIndex)
    }

    func updateItem(listID: UUID, item: ShoppingListItem) {
        guard let listIndex = listIndex(for: listID),
              let itemIndex = itemIndex(in: listIndex, itemID: item.id) else { return }
        lists[listIndex].items[itemIndex] = item
        touch(listIndex)
    }

    func incrementItem(listID: UUID, itemID: UUID) {
        guard let listIndex = listIndex(for: listID),
              let itemIndex = itemIndex(in: listIndex, itemID: itemID) else { return }
        let current = lists[listIndex].items[itemIndex].quantity ?? 0
        lists[listIndex].items[itemIndex].quantity = current + 1
        touch(listIndex)
    }

    func decrementItem(listID: UUID, itemID: UUID) {
        guard let listIndex = listIndex(for: listID),
              let itemIndex = itemIndex(in: listIndex, itemID: itemID) else { return }
        guard let current = lists[listIndex].items[itemIndex].quantity, current > 1 else {
            lists[listIndex].items[itemIndex].quantity = nil
            touch(listIndex)
            return
        }
        lists[listIndex].items[itemIndex].quantity = current - 1
        touch(listIndex)
    }

    func removeItem(listID: UUID, itemID: UUID) {
        guard let listIndex = listIndex(for: listID) else { return }
        lists[listIndex].items.removeAll { $0.id == itemID }
        touch(listIndex)
    }

    func list(for id: UUID) -> ShoppingList? {
        lists.first(where: { $0.id == id })
    }

    private func load() {
        if let decoded = decodeLists(forKey: storageKey) {
            lists = decoded.sorted { $0.updatedAt > $1.updatedAt }
            return
        }

        if let decoded = decodeLists(forKey: legacyStorageKey) {
            lists = decoded.sorted { $0.updatedAt > $1.updatedAt }
            persist()
            UserDefaults.standard.removeObject(forKey: legacyStorageKey)
            return
        }

        lists = []
    }

    private func decodeLists(forKey key: String) -> [ShoppingList]? {
        guard let raw = UserDefaults.standard.string(forKey: key),
              let data = raw.data(using: .utf8) else {
            return nil
        }

        return try? JSONDecoder().decode([ShoppingList].self, from: data)
    }

    private func persist() {
        do {
            let data = try JSONEncoder().encode(lists)
            let raw = String(data: data, encoding: .utf8) ?? "[]"
            UserDefaults.standard.set(raw, forKey: storageKey)
        } catch {
            UserDefaults.standard.set("[]", forKey: storageKey)
        }
    }

    private func touch(_ index: Int) {
        lists[index].updatedAt = Date()
        persist()
    }

    private func listIndex(for listID: UUID) -> Int? {
        lists.firstIndex(where: { $0.id == listID })
    }

    private func itemIndex(in listIndex: Int, itemID: UUID) -> Int? {
        lists[listIndex].items.firstIndex(where: { $0.id == itemID })
    }
}
