//
//  AnimatedWelcomeView.swift
//  CookFlow
//
//  Created by Codex on 2/15/26.
//

import SwiftUI
import UIKit

struct AnimatedWelcomeView: View {
    let onFinished: () -> Void

    @Environment(\.colorScheme) private var colorScheme
    @State private var visibleCount = 0
    @State private var hasStarted = false

    private let message = Array("Welcome to CookFlow 1.0")

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer(minLength: 0)

                Text(String(message.prefix(visibleCount)))
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(foregroundColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, DesignSystem.Spacing.xl)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .task {
            guard !hasStarted else { return }
            hasStarted = true

            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.prepare()

            for index in message.indices {
                try? await Task.sleep(for: .milliseconds(55))
                guard !Task.isCancelled else { return }

                await MainActor.run {
                    visibleCount = index + 1
                    generator.impactOccurred(intensity: 0.45)
                    generator.prepare()
                }
            }

            try? await Task.sleep(for: .milliseconds(400))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                onFinished()
            }
        }
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }

    private var foregroundColor: Color {
        colorScheme == .dark ? DesignSystem.Colors.textCream : DesignSystem.Colors.backgroundNearBlack
    }
}

#Preview {
    AnimatedWelcomeView(onFinished: {})
}
