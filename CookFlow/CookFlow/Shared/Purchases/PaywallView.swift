//
//  PaywallView.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var entitlementManager = EntitlementManager()
    @StateObject private var purchaseManager: PurchaseManager
    @State private var showComingSoonAlert = false

    init() {
        let entitlement = EntitlementManager()
        _entitlementManager = StateObject(wrappedValue: entitlement)
        _purchaseManager = StateObject(wrappedValue: PurchaseManager(entitlementManager: entitlement))
    }

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Text("CookFlow Premium")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Text("Unlock the full AI experience.")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    premiumBullet("Import recipes from any website")
                    premiumBullet("Fridge photo to instant recipe ideas")
                    premiumBullet("Calories, macros, and smart swaps")
                }

                PrimaryButton(title: "Start Premium (Annual)") {
                    if entitlementManager.hasPro {
                        dismiss()
                    } else {
                        showComingSoonAlert = true
                    }
                }

                SecondaryButton(title: "Monthly") {
                    Task {
                        try? await purchaseManager.purchaseMonthly()
                    }
                }

                Button("Restore Purchases") {
                    Task { await purchaseManager.restore() }
                }
                .font(DesignSystem.Fonts.link)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .buttonStyle(.plain)

                Text("Cancel anytime")
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack(spacing: DesignSystem.Spacing.md) {
                    Button("Terms") { showComingSoonAlert = true }
                    Button("Privacy") { showComingSoonAlert = true }
                }
                .font(DesignSystem.Fonts.link)
                .foregroundColor(DesignSystem.Colors.textMuted)
                .frame(maxWidth: .infinity, alignment: .center)

                Button(action: { dismiss() }) {
                    Text("Not now")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textCream)
                }
                .buttonStyle(.plain)

                if let errorMessage = purchaseManager.errorMessage {
                    Text(errorMessage)
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.xl)
        }
        .alert("Coming soon", isPresented: $showComingSoonAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Annual plan and legal links will be connected in the next billing phase.")
        }
    }

    private func premiumBullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: DesignSystem.Spacing.xs) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.ctaGreen)
                .padding(.top, 2)

            Text(text)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textCream)
        }
    }
}

#Preview {
    PaywallView()
        .preferredColorScheme(.dark)
}
