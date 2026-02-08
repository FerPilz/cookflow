//
//  MenuView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct MenuView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTab: AppTab
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            List {
                Section("Navigate") {
                    menuButton(title: "Home", systemImage: "house") {
                        selectedTab = .home
                        isPresented = false
                    }
                    menuButton(title: "Search", systemImage: "magnifyingglass") {
                        selectedTab = .search
                        isPresented = false
                    }
                    menuButton(title: "Planner", systemImage: "calendar") {
                        selectedTab = .planner
                        isPresented = false
                    }
                    menuButton(title: "Favorites", systemImage: "heart") {
                        selectedTab = .favorites
                        isPresented = false
                    }
                }

                Section("Monetization") {
                    Button(action: { showPaywall = true }) {
                        menuRow(title: "Upgrade to Premium", systemImage: "crown")
                    }
                    Button(action: {}) {
                        menuRow(title: "Restore Purchases", systemImage: "arrow.counterclockwise")
                    }
                }

                Section("Utility") {
                    NavigationLink {
                        PlaceholderDetailView(title: "Settings")
                    } label: {
                        menuRow(title: "Settings", systemImage: "gearshape")
                    }

                    NavigationLink {
                        PlaceholderDetailView(title: "Help / Feedback")
                    } label: {
                        menuRow(title: "Help / Feedback", systemImage: "questionmark.circle")
                    }

                    NavigationLink {
                        PlaceholderDetailView(title: "Terms & Privacy")
                    } label: {
                        menuRow(title: "Terms & Privacy", systemImage: "doc.text")
                    }
                }

                Section("Account") {
                    NavigationLink {
                        PlaceholderDetailView(title: "Sign out")
                    } label: {
                        menuRow(title: "Sign out", systemImage: "arrow.backward.square")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(DesignSystem.Colors.backgroundNearBlack)
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                    .foregroundColor(DesignSystem.Colors.textCream)
                }
            }
        }
        .tint(DesignSystem.Colors.textCream)
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
    }

    private func menuButton(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            menuRow(title: title, systemImage: systemImage)
        }
    }

    private func menuRow(title: String, systemImage: String) -> some View {
        HStack(spacing: DesignSystem.Spacing.md) {
            Image(systemName: systemImage)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)
                .frame(width: 22)

            Text(title)
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            Spacer()
        }
        .padding(.vertical, 6)
        .listRowBackground(DesignSystem.Colors.card)
    }
}

private struct PlaceholderDetailView: View {
    let title: String

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            Text("Coming soon")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MenuView(isPresented: .constant(true), selectedTab: .constant(.home))
        .preferredColorScheme(.dark)
}
