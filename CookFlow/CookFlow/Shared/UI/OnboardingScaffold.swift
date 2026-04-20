//
//  OnboardingScaffold.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI
import UIKit
import AVFoundation

struct OnboardingScaffold<HeaderContent: View, BodyContent: View, FooterAboveContent: View, FooterBelowContent: View>: View {
    @EnvironmentObject private var themeManager: ThemeManager
    let headerContent: () -> HeaderContent
    let bodyContent: () -> BodyContent
    let footerAboveCTAContent: () -> FooterAboveContent
    let footerBelowCTAContent: () -> FooterBelowContent
    let primaryCTATitle: String
    let onPrimaryCTA: () -> Void
    let showsPrimaryCTA: Bool
    let isPrimaryEnabled: Bool
    let usesVideoBackground: Bool
    let videoResourceName: String?
    let showsTopBanner: Bool

    init(
        primaryCTATitle: String,
        showsPrimaryCTA: Bool = true,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        usesVideoBackground: Bool = false,
        videoResourceName: String? = nil,
        showsTopBanner: Bool = true,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        @ViewBuilder footerAboveCTAContent: @escaping () -> FooterAboveContent,
        @ViewBuilder footerBelowCTAContent: @escaping () -> FooterBelowContent
    ) {
        self.primaryCTATitle = primaryCTATitle
        self.showsPrimaryCTA = showsPrimaryCTA
        self.isPrimaryEnabled = isPrimaryEnabled
        self.onPrimaryCTA = onPrimaryCTA
        self.usesVideoBackground = usesVideoBackground
        self.videoResourceName = videoResourceName
        self.showsTopBanner = showsTopBanner
        self.headerContent = headerContent
        self.bodyContent = bodyContent
        self.footerAboveCTAContent = footerAboveCTAContent
        self.footerBelowCTAContent = footerBelowCTAContent
    }

    var body: some View {
        let colors = themeManager.palette

        GeometryReader { proxy in
            let height = proxy.size.height
            let headerHeight = height * 0.25
            let footerHeight: CGFloat = 220
            let safeAreaBottom = proxy.safeAreaInsets.bottom

            ZStack {
                backgroundView

                if showsTopBanner {
                    colors.secondaryBackground
                        .opacity(themeManager.selectedTheme == .night ? 0.56 : 0.42)
                        .frame(height: headerHeight)
                        .frame(maxHeight: .infinity, alignment: .top)
                }

                VStack(spacing: 0) {
                    headerContent()
                        .frame(height: headerHeight)
                        .frame(maxWidth: .infinity)

                    bodyContent()
                        .frame(height: height - headerHeight - footerHeight)
                        .frame(maxWidth: .infinity)

                    footerView(footerHeight: footerHeight, safeAreaBottom: safeAreaBottom)
                        .frame(height: footerHeight)
                        .frame(maxWidth: .infinity)
                }
            }
            .ignoresSafeArea()
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        let colors = themeManager.palette

        if usesVideoBackground {
            ZStack {
                if let videoResourceName {
                    LoopingVideoView(resourceName: videoResourceName, resourceExtension: "mp4", videoGravity: .resizeAspectFill)
                        .ignoresSafeArea()
                } else {
                    colors.background
                        .ignoresSafeArea()
                }

                LinearGradient(
                    colors: [
                        colors.background.opacity(themeManager.selectedTheme == .night ? 0.55 : 0.3),
                        colors.background.opacity(themeManager.selectedTheme == .night ? 0.82 : 0.5)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
        } else if let uiImage = UIImage(named: "OnboardingBG1") {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .clipped()
                .ignoresSafeArea()
        } else {
            colors.background
                .ignoresSafeArea()
        }
    }

    private func footerView(footerHeight: CGFloat, safeAreaBottom: CGFloat) -> some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            footerAboveCTAContent()
                .frame(maxWidth: .infinity, alignment: .top)

            Spacer(minLength: 0)

            if showsPrimaryCTA {
                PrimaryButton(title: primaryCTATitle, isEnabled: isPrimaryEnabled, action: onPrimaryCTA)
                    .frame(height: 56)
            }

            footerBelowCTAContent()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.top, DesignSystem.Spacing.sm)
        .padding(.bottom, max(DesignSystem.Spacing.md, safeAreaBottom))
        .frame(height: footerHeight, alignment: .top)
    }
}



extension OnboardingScaffold where FooterAboveContent == EmptyView {
    init(
        primaryCTATitle: String,
        showsPrimaryCTA: Bool = true,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        usesVideoBackground: Bool = false,
        videoResourceName: String? = nil,
        showsTopBanner: Bool = true,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        @ViewBuilder footerBelowCTAContent: @escaping () -> FooterBelowContent
    ) {
        self.init(
            primaryCTATitle: primaryCTATitle,
            showsPrimaryCTA: showsPrimaryCTA,
            isPrimaryEnabled: isPrimaryEnabled,
            onPrimaryCTA: onPrimaryCTA,
            usesVideoBackground: usesVideoBackground,
            videoResourceName: videoResourceName,
            showsTopBanner: showsTopBanner,
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
        showsPrimaryCTA: Bool = true,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        usesVideoBackground: Bool = false,
        videoResourceName: String? = nil,
        showsTopBanner: Bool = true,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        @ViewBuilder footerAboveCTAContent: @escaping () -> FooterAboveContent
    ) {
        self.init(
            primaryCTATitle: primaryCTATitle,
            showsPrimaryCTA: showsPrimaryCTA,
            isPrimaryEnabled: isPrimaryEnabled,
            onPrimaryCTA: onPrimaryCTA,
            usesVideoBackground: usesVideoBackground,
            videoResourceName: videoResourceName,
            showsTopBanner: showsTopBanner,
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
        showsPrimaryCTA: Bool = true,
        isPrimaryEnabled: Bool = true,
        onPrimaryCTA: @escaping () -> Void,
        usesVideoBackground: Bool = false,
        videoResourceName: String? = nil,
        showsTopBanner: Bool = true,
        @ViewBuilder headerContent: @escaping () -> HeaderContent,
        @ViewBuilder bodyContent: @escaping () -> BodyContent
    ) {
        self.init(
            primaryCTATitle: primaryCTATitle,
            showsPrimaryCTA: showsPrimaryCTA,
            isPrimaryEnabled: isPrimaryEnabled,
            onPrimaryCTA: onPrimaryCTA,
            usesVideoBackground: usesVideoBackground,
            videoResourceName: videoResourceName,
            showsTopBanner: showsTopBanner,
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
    .environmentObject(ThemeManager())
}
