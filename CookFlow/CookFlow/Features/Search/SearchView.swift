//
//  SearchView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                SearchBar(text: $searchText)

                Text(isSearching ? "Results" : "Categories")
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)

                LazyVGrid(columns: columns, spacing: 12) {
                    if isSearching {
                        ForEach(filteredRecipes) { recipe in
                            RecipeCardView(recipe: recipe, width: nil, height: 140)
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        ForEach(SampleData.categories) { category in
                            CategoryCardView(category: category)
                        }
                    }
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, DesignSystem.Spacing.md)
            .padding(.bottom, 96)
        }
        .background(DesignSystem.Colors.backgroundNearBlack)
    }

    private var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var filteredRecipes: [Recipe] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return SampleData.allRecipes }
        return SampleData.allRecipes.filter { $0.title.lowercased().contains(query) }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(.dark)
}
