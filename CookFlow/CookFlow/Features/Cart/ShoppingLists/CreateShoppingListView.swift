import SwiftUI

struct CreateShoppingListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var shoppingListStore: ShoppingListStore

    var onSave: ((UUID) -> Void)?
    private let suggestionSource = ShoppingSuggestionSource()

    @State private var listName = ""
    @State private var draftItems: [DraftShoppingItem] = [DraftShoppingItem()]

    var body: some View {
        let colors = themeManager.palette

        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                    Text("Shopping List")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(colors.primaryText)

                    InputField(label: "Shopping List Name", placeholder: "Weekly groceries", text: $listName)

                    columnHeader

                    ForEach($draftItems) { $item in
                        HStack(alignment: .center, spacing: DesignSystem.Spacing.sm) {
                            TextField(
                                "",
                                text: $item.name,
                                prompt: Text("Item")
                                    .foregroundColor(colors.secondaryText.opacity(0.8))
                            )
                                .textInputAutocapitalization(.words)
                                .disableAutocorrection(true)
                                .font(DesignSystem.Fonts.subtitle)
                                .foregroundColor(colors.primaryText)
                                .tint(colors.accent)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                                .background(DesignSystem.Colors.card)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                            Picker("Qty", selection: $item.quantity) {
                                ForEach(1...10, id: \.self) { value in
                                    Text("\(value)").tag(Double(value))
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(colors.primaryText)
                            .frame(width: 64)
                            .padding(.vertical, 6)
                            .background(DesignSystem.Colors.card)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                            Button(action: { removeRow(id: item.id) }) {
                                Image(systemName: "trash")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(DesignSystem.Colors.textMuted)
                                    .frame(width: 32, height: 32)
                                    .background(DesignSystem.Colors.card)
                                    .clipShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .disabled(draftItems.count == 1)
                        }
                    }

                    Button(action: addRow) {
                        HStack(spacing: DesignSystem.Spacing.xs) {
                            Image(systemName: "plus")
                            Text("Add item")
                        }
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(colors.primaryText)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(DesignSystem.Colors.card)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .buttonStyle(.plain)

                    PrimaryButton(title: "Save", isEnabled: true) {
                        saveList()
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, DesignSystem.Spacing.lg)
            }
            .background(colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(colors.primaryText)
                }
            }
        }
    }

    private func saveList() {
        let trimmedListName = listName.trimmingCharacters(in: .whitespacesAndNewlines)
        let resolvedListName = trimmedListName.isEmpty ? defaultListName() : trimmedListName

        let items: [ShoppingListItem] = draftItems.compactMap { draft in
            let trimmedName = draft.name.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmedName.isEmpty else { return nil }
            return ShoppingListItem(
                name: trimmedName,
                quantity: draft.quantity,
                unit: nil,
                isChecked: false,
                sourceRecipes: [],
                category: inferredCategory(for: trimmedName),
                isManualItem: true
            )
        }

        if let existing = shoppingListStore.lists.first(where: { $0.name.lowercased() == resolvedListName.lowercased() }) {
            shoppingListStore.updateList(id: existing.id, name: resolvedListName, items: items)
            onSave?(existing.id)
        } else {
            let created = shoppingListStore.createList(name: resolvedListName, items: items)
            onSave?(created.id)
        }
        dismiss()
    }

    private func addRow() {
        draftItems.append(DraftShoppingItem())
    }

    private func removeRow(id: UUID) {
        guard draftItems.count > 1 else { return }
        draftItems.removeAll { $0.id == id }
    }

    private func defaultListName() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d"
        return "Shopping List \(formatter.string(from: Date()))"
    }

    private var columnHeader: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            Text("Item")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Qty")
                .frame(width: 64, alignment: .leading)
            Text("")
                .frame(width: 32)
        }
        .font(DesignSystem.Fonts.valueProp)
        .foregroundColor(DesignSystem.Colors.textMuted)
    }

    private func inferredCategory(for name: String) -> String {
        let normalizedName = ShoppingItem.normalize(name)
        if let exactMatch = suggestionSource.matches(for: name).first(where: { $0.normalizedName == normalizedName }) {
            return exactMatch.category ?? "Other"
        }
        return suggestionSource.matches(for: name).first?.category ?? "Other"
    }
}

private struct DraftShoppingItem: Identifiable {
    let id = UUID()
    var name = ""
    var quantity = 1.0
}

#Preview {
    CreateShoppingListView()
        .environmentObject(ShoppingListStore())
        .environmentObject(ThemeManager(theme: .light))
        .preferredColorScheme(.light)
}
