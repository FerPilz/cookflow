//
//  ProfileView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
    @AppStorage("userName") private var userName = "Gaby Pilz"
    @AppStorage("userEmail") private var userEmail = "gaby@cookflow.app"

    var body: some View {
        let colors = themeManager.palette

        NavigationStack {
            VStack(spacing: DesignSystem.Spacing.lg) {
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 64, weight: .regular))
                        .foregroundColor(colors.primaryText)

                    Text(userName)
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(colors.primaryText)

                    Text(userEmail)
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(colors.secondaryText)
                }

                VStack(spacing: DesignSystem.Spacing.sm) {
                    Text("Subscription: Free")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(colors.secondaryText)

                    PrimaryButton(title: "Upgrade to Premium") {
                    }

                    Button(action: {}) {
                        Text("Restore Purchases")
                            .font(DesignSystem.Fonts.link)
                            .foregroundColor(colors.primaryText)
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                    Text("Appearance")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(colors.primaryText)

                    Text("Light mode is the active app appearance for now.")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(colors.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(DesignSystem.Spacing.md)
                .background(colors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))

                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text("Preferences")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(colors.primaryText)

                    Text("Diet: Balanced")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(colors.secondaryText)

                    Text("Goal: Quick weeknights")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(colors.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            }
            .padding(DesignSystem.Spacing.lg)
            .background(colors.background)
            .navigationTitle("Profile")
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
    ProfileView()
        .environmentObject(ThemeManager(theme: .light))
        .environment(\.colorScheme, .light)
}
