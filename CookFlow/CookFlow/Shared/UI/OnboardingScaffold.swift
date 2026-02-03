//
//  OnboardingScaffold.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit

struct OnboardingScaffold<HeaderContent: View, BodyContent: View, FooterAboveContent: View, FooterBelowContent: View>: View {
    let headerContent: () -> HeaderContent
    let bodyContent: () -> BodyContent
    let footerAboveCTAContent: () -> FooterAboveContent
    let footerBelowCTAContent: () -> FooterBelowContent
    let primaryCTATitle: String
    let onPrimaryCTA: () -> Void
    let isPrimaryEnabled: Bool

    init(
        primaryCTATitle: String,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        @ViewBuilder footerAboveCTAContent: @escaping () -> FooterAboveContent,
        @ViewBuilder footerBelowCTAContent: @escaping () -> FooterBelowContent
    ) {
        self.primaryCTATitle = primaryCTATitle
        self.isPrimaryEnabled = isPrimaryEnabled
        self.onPrimaryCTA = onPrimaryCTA
        self.headerContent = headerContent
        self.bodyContent = bodyContent
        self.footerAboveCTAContent = footerAboveCTAContent
        self.footerBelowCTAContent = footerBelowCTAContent
    }

    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = proxy.size.width
            let headerHeight = height * 0.20
            let footerHeight = height * 0.15

            ZStack {
                backgroundView

                Color.black
                    .opacity(0.56)
                    .frame(height: headerHeight)
                    .frame(maxHeight: .infinity, alignment: .top)

                VStack(spacing: 0) {
                    headerContent()
                        .frame(height: headerHeight)
                        .frame(maxWidth: .infinity)

                    bodyContent()
                        .frame(height: height - headerHeight - footerHeight)
                        .frame(maxWidth: .infinity)

                    footerView(width: width, footerHeight: footerHeight)
                        .frame(height: footerHeight)
                        .frame(maxWidth: .infinity)
                }
            }
            .ignoresSafeArea()
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        if let uiImage = UIImage(named: "OnboardingBG1") {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // tweak
                .clipped()
                .ignoresSafeArea()
        } else {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()
        }
        
        
    }
    
    

    private func footerView(width: CGFloat, footerHeight: CGFloat) -> some View {
        VStack(spacing: 12) {

            // Above CTA (Back / sign-in links etc.)
            footerAboveCTAContent()
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, DesignSystem.Spacing.md)

            // CTA button (no .position)
            PrimaryButton(title: primaryCTATitle, isEnabled: isPrimaryEnabled, action: onPrimaryCTA)
                .padding(.top, 4)

            // Below CTA (Step 1 of 4)
            footerBelowCTAContent()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 6)

        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.bottom, DesignSystem.Spacing.md)
        .frame(height: footerHeight, alignment: .top)
    }

        }



extension OnboardingScaffold where FooterAboveContent == EmptyView {
    init(
        primaryCTATitle: String,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        @ViewBuilder footerBelowCTAContent: @escaping () -> FooterBelowContent
    ) {
        self.init(
            primaryCTATitle: primaryCTATitle,
            isPrimaryEnabled: isPrimaryEnabled,
            onPrimaryCTA: onPrimaryCTA,
            headerContent: headerContent,
            bodyContent: bodyContent,
            footerAboveCTAContent: { EmptyView() },
            footerBelowCTAContent: footerBelowCTAContent
        )
    }
}

extension OnboardingScaffold where FooterBelowContent == EmptyView {
    init(
        primaryCTATitle: String,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        @ViewBuilder footerAboveCTAContent: @escaping () -> FooterAboveContent
    ) {
        self.init(
            primaryCTATitle: primaryCTATitle,
            isPrimaryEnabled: isPrimaryEnabled,
            onPrimaryCTA: onPrimaryCTA,
            headerContent: headerContent,
            bodyContent: bodyContent,
            footerAboveCTAContent: footerAboveCTAContent,
            footerBelowCTAContent: { EmptyView() }
        )
    }
}

extension OnboardingScaffold where FooterAboveContent == EmptyView, FooterBelowContent == EmptyView {
    init(
        primaryCTATitle: String,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent
    ) {
        self.init(
            primaryCTATitle: primaryCTATitle,
            isPrimaryEnabled: isPrimaryEnabled,
            onPrimaryCTA: onPrimaryCTA,
            headerContent: headerContent,
            bodyContent: bodyContent,
            footerAboveCTAContent: { EmptyView() },
            footerBelowCTAContent: { EmptyView() }
        )
    }
}

#Preview {
    OnboardingScaffold(
        primaryCTATitle: "Continue",
        onPrimaryCTA: {}
    ) {
        VStack(spacing: DesignSystem.Spacing.md) {
            AppLogoView()
                .frame(height: 220)
            Text("CookFlow")
                .font(DesignSystem.Fonts.appName)
                .foregroundColor(DesignSystem.Colors.textCream)
        }
    } bodyContent: {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("Welcome")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)
            Text("Plan meals faster with smart flows.")
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
    }
}
