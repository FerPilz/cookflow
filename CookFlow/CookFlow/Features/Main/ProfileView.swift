//
//  ProfileView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("userName") private var userName = "Gaby Pilz"
    @AppStorage("userEmail") private var userEmail = "gaby@cookflow.app"
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            VStack(spacing: DesignSystem.Spacing.lg) {
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 64, weight: .regular))
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Text(userName)
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Text(userEmail)
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }

                VStack(spacing: DesignSystem.Spacing.sm) {
                    Text("Subscription: Free")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)

                    PrimaryButton(title: "Upgrade to Premium") {
                        showPaywall = true
                    }

                    Button(action: {}) {
                        Text("Restore Purchases")
                            .font(DesignSystem.Fonts.link)
                            .foregroundColor(DesignSystem.Colors.textCream)
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    Text("Preferences")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Text("Diet: Balanced")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)

                    Text("Goal: Quick weeknights")
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            }
            .padding(DesignSystem.Spacing.lg)
            .background(DesignSystem.Colors.backgroundNearBlack)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(DesignSystem.Colors.textCream)
                }
            }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
