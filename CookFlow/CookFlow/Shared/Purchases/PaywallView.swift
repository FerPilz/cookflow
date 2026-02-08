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

    init() {
        let entitlement = EntitlementManager()
        _entitlementManager = StateObject(wrappedValue: entitlement)
        _purchaseManager = StateObject(wrappedValue: PurchaseManager(entitlementManager: entitlement))
    }

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            VStack(spacing: DesignSystem.Spacing.lg) {
                VStack(spacing: DesignSystem.Spacing.sm) {
                    Text("CookFlow Pro")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Text("Unlock all recipes and meal plans.")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .multilineTextAlignment(.center)

                PrimaryButton(title: "Start subscription") {
                    Task {
                        try? await purchaseManager.purchaseMonthly()
                    }
                }

                Button(action: {
                    Task { await purchaseManager.restore() }
                }) {
                    Text("Restore purchases")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .buttonStyle(.plain)

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
    }
}

#Preview {
    PaywallView()
        .preferredColorScheme(.dark)
}
