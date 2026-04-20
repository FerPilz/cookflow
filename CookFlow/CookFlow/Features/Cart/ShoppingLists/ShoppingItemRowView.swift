import SwiftUI

struct ShoppingItemRowView: View {
    let item: ShoppingItem
    let onToggleChecked: () -> Void
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: DesignSystem.Spacing.sm) {
            Button(action: onToggleChecked) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(item.isChecked ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.textTertiary)
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(.plain)

            HStack(alignment: .firstTextBaseline, spacing: DesignSystem.Spacing.xs) {
                Text(item.name)
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .strikethrough(item.isChecked)
                    .lineLimit(1)

                if let quantityText = item.displayQuantityUnit {
                    Text(quantityText)
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let source = item.displaySource, !item.isManualItem {
                Text(source)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .lineLimit(1)
                    .frame(maxWidth: 96, alignment: .trailing)
            }

            HStack(spacing: 6) {
                quantityButton(systemName: "minus", action: onDecrement)
                quantityButton(systemName: "plus", action: onIncrement)
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.md)
        .padding(.vertical, 10)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private func quantityButton(systemName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)
                .frame(width: 28, height: 28)
                .background(DesignSystem.Colors.secondaryBackground)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ShoppingItemRowView(
        item: ShoppingItem(
            name: "Cherry tomatoes",
            quantity: 2,
            unit: "packs",
            sourceRecipes: [ShoppingItemSource(recipeID: "recipe-1", recipeTitle: "Mediterranean Bowl")],
            category: "Produce"
        ),
        onToggleChecked: {},
        onIncrement: {},
        onDecrement: {}
    )
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
