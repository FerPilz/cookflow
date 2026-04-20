//
//  RecipeDetailView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @EnvironmentObject private var cart: CartStore
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var checkedIngredients: Set<Int> = []

    var body: some View {
        let colors = themeManager.palette

        ScrollView {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                heroImage

                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                    Text(recipe.title)
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(colors.primaryText)

                    metadataRow
                }

                ingredientsSection
                instructionsSection
                howToCookSection
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, DesignSystem.Spacing.md)
            .padding(.bottom, 96)
        }
        .background(colors.background)
    }

    private var heroImage: some View {
        HeroImageView(imageName: recipe.heroImageName)
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
    }

    private var metadataRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                metadataPill(title: "Calories", value: calorieText, isBlurred: recipe.calories == nil)
                metadataPill(title: "Category", value: recipe.category)
                metadataPill(title: "Prep", value: prepText)
                metadataPill(title: "Cook", value: cookText)
                metadataPill(title: "Amount", value: recipe.quantityText)
            }
        }
    }

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack {
                Text("Ingredients")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textCream)

                Spacer()

                Button(action: { cart.addAll(cartIngredients, for: recipe) }) {
                    Text("Add all ingredients")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(DesignSystem.Colors.ctaGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .buttonStyle(.plain)
            }

            ForEach(ingredientLines.indices, id: \.self) { index in
                HStack(spacing: DesignSystem.Spacing.sm) {
                    Button(action: { toggleIngredient(index) }) {
                        Image(systemName: checkedIngredients.contains(index) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(checkedIngredients.contains(index) ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.textMuted)
                    }
                    .buttonStyle(.plain)

                    Text(ingredientLines[index])
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .strikethrough(checkedIngredients.contains(index))

                    Spacer()

                    Button(action: { addIngredientToCart(index) }) {
                        Text("Add")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(DesignSystem.Colors.textCream)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(DesignSystem.Colors.card)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 6)
            }
        }
    }

    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Instructions")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)

            ForEach(instructionLines.indices, id: \.self) { index in
                HStack(alignment: .top, spacing: DesignSystem.Spacing.sm) {
                    Text("\(index + 1)")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(width: 22, alignment: .leading)

                    Text(instructionLines[index])
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
    }

    private var howToCookSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("How to cook")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)

            VStack(spacing: DesignSystem.Spacing.sm) {
                HowToCardView(title: "Prep your station", detail: "Set out tools and prep ingredients.")
                HowToCardView(title: "Cook with heat", detail: "Use medium heat for even browning.")
                HowToCardView(title: "Finish and plate", detail: "Rest, slice, and garnish.")
            }
        }
    }

    private func metadataPill(title: String, value: String, isBlurred: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textMuted)

            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)
                .blur(radius: isBlurred ? 4 : 0)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var calorieText: String {
        if let calories = recipe.calories {
            return "\(calories) kcal"
        }
        return "Pro"
    }

    private var prepText: String {
        if let prepMinutes = recipe.prepMinutes {
            return "\(prepMinutes)m"
        }
        return "-"
    }

    private var cookText: String {
        if let cookMinutes = recipe.cookMinutes {
            return "\(cookMinutes)m"
        }
        return "-"
    }

    private var ingredientLines: [String] {
        recipe.ingredientsText
            .split(separator: "\n", omittingEmptySubsequences: true)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    private var cartIngredients: [CartIngredient] {
        ShoppingIngredientParser.cartIngredients(from: recipe)
    }

    private var instructionLines: [String] {
        recipe.instructionsText
            .split(separator: "\n", omittingEmptySubsequences: true)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    private func toggleIngredient(_ index: Int) {
        if checkedIngredients.contains(index) {
            checkedIngredients.remove(index)
        } else {
            checkedIngredients.insert(index)
        }
    }

    private func parseIngredientLine(_ line: String) -> CartIngredient {
        ShoppingIngredientParser.parseIngredientLine(line)
    }

    private func addIngredientToCart(_ index: Int) {
        guard ingredientLines.indices.contains(index) else { return }
        cart.add(ingredient: parseIngredientLine(ingredientLines[index]), for: recipe)
    }
}

private struct HowToCardView: View {
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            Text(detail)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
        .padding(DesignSystem.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
    }
}

#Preview("Light Mode") {
    RecipeDetailView(recipe: SampleData.recipes(for: "Top Picks for You").first ?? Recipe(title: "Miso Salmon Bowl", subtitle: "Savory glaze", category: "Top Picks for You"))
        .environmentObject(CartStore())
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}

#Preview("Dark Mode") {
    RecipeDetailView(recipe: SampleData.recipes(for: "Top Picks for You").first ?? Recipe(title: "Miso Salmon Bowl", subtitle: "Savory glaze", category: "Top Picks for You"))
        .environmentObject(CartStore())
        .environmentObject(ThemeManager(theme: .dark))
        .environment(\.colorScheme, .dark)
}
