import SwiftUI

struct ShoppingListsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var shoppingListStore: ShoppingListStore
    @State private var isCreateListPresented = false
    @State private var createdListID: UUID?

    private let updatedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        let colors = themeManager.palette

        Group {
            if shoppingListStore.lists.isEmpty {
                VStack(spacing: DesignSystem.Spacing.md) {
                    Image(systemName: "list.bullet.rectangle")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textTertiary)

                    Text("No shopping lists yet")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Button(action: { isCreateListPresented = true }) {
                        Text("Create Shopping List")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.onAccentText)
                            .padding(.horizontal, DesignSystem.Spacing.md)
                            .padding(.vertical, 12)
                            .background(DesignSystem.Colors.ctaGreen)
                            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(colors.background)
            } else {
                List {
                    ForEach(shoppingListStore.lists, id: \.id) { list in
                        NavigationLink(value: list.id) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(list.name)
                                    .font(DesignSystem.Fonts.subtitle)
                                    .foregroundColor(DesignSystem.Colors.textCream)

                                Text("\(list.items.count) items · Updated \(updatedFormatter.string(from: list.updatedAt))")
                                    .font(DesignSystem.Fonts.valueProp)
                                    .foregroundColor(DesignSystem.Colors.textMuted)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(DesignSystem.Colors.card)
                    }
                    .onDelete { offsets in
                        for index in offsets {
                            let list = shoppingListStore.lists[index]
                            shoppingListStore.deleteList(id: list.id)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(colors.background)
            }
        }
        .navigationTitle("Shopping Lists")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: UUID.self) { listID in
            ShoppingListDetailView(listID: listID)
        }
        .navigationDestination(isPresented: Binding(
            get: { createdListID != nil },
            set: { isPresented in
                if !isPresented { createdListID = nil }
            }
        )) {
            if let listID = createdListID {
                ShoppingListDetailView(listID: listID)
            }
        }
        .sheet(isPresented: $isCreateListPresented) {
            CreateShoppingListView(onSave: { listID in
                createdListID = listID
            })
            .environmentObject(shoppingListStore)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(colors.primaryText)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Back")
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isCreateListPresented = true }) {
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(colors.primaryText)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Create shopping list")
            }
        }
        .background(colors.background)
        .tint(colors.primaryText)
    }
}

#Preview {
    NavigationStack {
        ShoppingListsView()
            .environmentObject(ShoppingListStore())
            .environmentObject(ThemeManager(theme: .light))
            .preferredColorScheme(.light)
    }
}
