//
//  HomeView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @AppStorage("homeSelectedCategory") private var homeSelectedCategory = ""
    @State private var selectedCarouselIndex = 0

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                    topCarouselSection

                    categoryStrip(proxy: proxy)

                    ForEach(sectionTitles, id: \.self) { title in
                        HomeSectionView(
                            title: title,
                            recipes: SampleData.recipes(for: title),
                            favoriteIDs: favoritesStore.favoriteIDs,
                            onToggleFavorite: { favoritesStore.toggle($0) }
                        )
                        .id(title)
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, 96)
            }
        }
    }

    private var sectionTitles: [String] {
        SampleData.sectionOrder.filter { $0 != "Top Picks for You" }
    }

    private var topCarouselSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Top Picks for You")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)

            TabView(selection: $selectedCarouselIndex) {
                ForEach(Array(SampleData.recipes(for: "Top Picks for You").enumerated()), id: \.offset) { index, recipe in
                    ZStack(alignment: .topTrailing) {
                        RecipeImageView(recipe: recipe)
                            .frame(height: 216)
                            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))

                        Button(action: { favoritesStore.toggle(recipe) }) {
                            Image(systemName: favoritesStore.isFavorite(recipe.id) ? "heart.fill" : "heart")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(DesignSystem.Colors.textCream)
                                .frame(width: 44, height: 44)
                                .background(Color.black.opacity(0.35))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .padding(8)
                    }
                    .tag(index)
                }
            }
            .frame(height: 216)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: carouselCount) { newValue in
                if newValue > 0, selectedCarouselIndex >= newValue {
                    selectedCarouselIndex = max(0, newValue - 1)
                }
            }

            HStack(spacing: 6) {
                ForEach(0..<carouselCount, id: \.self) { index in
                    Circle()
                        .fill(index == selectedCarouselIndex ? DesignSystem.Colors.textCream : DesignSystem.Colors.textMuted)
                        .frame(width: 6, height: 6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)

            if let recipe = carouselRecipe {
                Text(recipe.title)
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .lineLimit(2)

                Text(recipe.subtitle)
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .lineLimit(1)
            }
        }
    }

    private func categoryStrip(proxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(SampleData.categories) { category in
                    let isSelected = homeSelectedCategory == category.title
                    Button(action: {
                        homeSelectedCategory = category.title
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(category.title, anchor: .top)
                        }
                    }) {
                        VStack(spacing: 6) {
                            Image(systemName: category.systemImageName)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(DesignSystem.Colors.textCream)
                                .frame(width: 36, height: 36)
                                .background(DesignSystem.Colors.card)
                                .clipShape(Circle())

                            Text(category.title)
                                .font(DesignSystem.Fonts.valueProp)
                                .foregroundColor(DesignSystem.Colors.textCream)
                                .lineLimit(1)
                        }
                        .frame(width: 88)
                        .padding(.vertical, DesignSystem.Spacing.xs)
                        .background(isSelected ? DesignSystem.Colors.ctaGreen.opacity(0.25) : DesignSystem.Colors.card.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(isSelected ? DesignSystem.Colors.ctaGreen : Color.clear, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var carouselRecipes: [Recipe] {
        SampleData.recipes(for: "Top Picks for You")
    }

    private var carouselCount: Int {
        carouselRecipes.count
    }

    private var carouselRecipe: Recipe? {
        guard !carouselRecipes.isEmpty, selectedCarouselIndex < carouselRecipes.count else { return nil }
        return carouselRecipes[selectedCarouselIndex]
    }
}

private struct RecipeImageView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            if let url = recipe.imageURL {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
    }

    private var placeholder: some View {
        LinearGradient(
            colors: [DesignSystem.Colors.card, DesignSystem.Colors.backgroundNearBlack],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
