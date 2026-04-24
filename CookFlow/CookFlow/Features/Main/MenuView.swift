//
//  MenuView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Binding var isPresented: Bool
    @Binding var selectedTab: AppTab
    let onTapProfile: () -> Void

    @State private var activeUtilitySheet: UtilitySheet?

    init(
        isPresented: Binding<Bool>,
        selectedTab: Binding<AppTab>,
        onTapProfile: @escaping () -> Void = {}
    ) {
        _isPresented = isPresented
        _selectedTab = selectedTab
        self.onTapProfile = onTapProfile
    }

    var body: some View {
        let colors = themeManager.palette

        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Menu")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(colors.primaryText)

                Spacer()

                Button(action: dismissMenu) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(colors.primaryText)
                        .frame(width: 36, height: 36)
                        .background(colors.cardBackground)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, DesignSystem.Spacing.md)
            .padding(.top, 56)
            .padding(.bottom, DesignSystem.Spacing.lg)

            VStack(alignment: .leading, spacing: 8) {
                menuButton(title: "Profile", systemImage: "person.crop.circle", action: {
                    dismissMenu()
                    onTapProfile()
                })
                menuButton(title: "Favorites", systemImage: "heart", action: {
                    selectedTab = .favorites
                    dismissMenu()
                })
                menuButton(title: "Premium", systemImage: "crown", action: {
                    dismissMenu()
                })
                menuButton(title: "Settings", systemImage: "gearshape", action: {
                    activeUtilitySheet = .settings
                })
                menuButton(title: "Help / Support", systemImage: "questionmark.circle", action: {
                    activeUtilitySheet = .help
                })
            }
            .padding(.horizontal, DesignSystem.Spacing.sm)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(colors.secondaryBackground)
        .sheet(item: $activeUtilitySheet, onDismiss: dismissMenu) { sheet in
            UtilitySheetView(title: sheet.title)
        }
    }

    @ViewBuilder
    private func menuButton(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        let colors = themeManager.palette

        Button(action: action) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                Image(systemName: systemImage)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(colors.primaryText)
                    .frame(width: 22)

                Text(title)
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(colors.primaryText)

                Spacer()
            }
            .padding(.horizontal, DesignSystem.Spacing.sm)
            .padding(.vertical, 12)
            .background(colors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private func dismissMenu() {
        withAnimation(.easeInOut(duration: 0.22)) {
            isPresented = false
        }
    }
}

private enum UtilitySheet: String, Identifiable {
    case settings
    case help

    var id: String { rawValue }

    var title: String {
        switch self {
        case .settings:
            return "Settings"
        case .help:
            return "Help / Support"
        }
    }
}

private struct UtilitySheetView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
    let title: String

    var body: some View {
        let colors = themeManager.palette

        NavigationStack {
            ZStack {
                colors.background
                    .ignoresSafeArea()

                Text("Coming soon")
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(colors.secondaryText)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(colors.primaryText)
                }
            }
        }
    }
}

#Preview("Light Mode") {
    MenuView(isPresented: .constant(true), selectedTab: .constant(.home))
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}
