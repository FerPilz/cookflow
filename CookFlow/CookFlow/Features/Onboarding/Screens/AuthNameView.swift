//
//  AuthNameView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct AuthNameView: View {
    @Binding var email: String
    @Binding var authProvider: String
    let onAuthenticated: () -> Void

    @State private var isSigningIn = false
    @State private var errorMessage = ""
    @AppStorage("cookflow.isSignedIn") private var isSignedIn = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DesignSystem.Spacing.md) {
                VStack(spacing: DesignSystem.Spacing.xs) {
                    Text("Log in to CookFlow")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .multilineTextAlignment(.center)

                    Text("Choose a sign-in method to continue.")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)

                AuthProviderButton(
                    title: "Continue with Apple",
                    icon: .apple,
                    action: { Task { await signInWithApple() } }
                )
                .disabled(isSigningIn)

                AuthProviderButton(
                    title: "Continue with Google",
                    icon: .google,
                    action: { Task { await signInWithGoogle() } }
                )
                .disabled(isSigningIn)

                HStack(spacing: DesignSystem.Spacing.sm) {
                    Rectangle()
                        .fill(DesignSystem.Colors.textMuted.opacity(0.35))
                        .frame(height: 1)

                    Text("OR")
                        .font(DesignSystem.Fonts.stepLabel)
                        .foregroundColor(DesignSystem.Colors.textMuted)

                    Rectangle()
                        .fill(DesignSystem.Colors.textMuted.opacity(0.35))
                        .frame(height: 1)
                }

                DSTextField(
                    placeholder: "Continue with Email",
                    text: $email
                )

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.xl)
            .padding(.top, DesignSystem.Spacing.sm)
            .padding(.bottom, DesignSystem.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    @MainActor
    private func signInWithApple() async {
        isSigningIn = true
        defer { isSigningIn = false }
        errorMessage = ""

        do {
            let result = try await AuthService.shared.signInWithApple()
            applyAuthResult(result)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    private func signInWithGoogle() async {
        isSigningIn = true
        defer { isSigningIn = false }
        errorMessage = ""

        do {
            let result = try await AuthService.shared.signInWithGoogle()
            applyAuthResult(result)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func applyAuthResult(_ result: AuthResult) {
        if let emailValue = result.email, !emailValue.isEmpty {
            email = emailValue
        }
        isSignedIn = true
        errorMessage = ""
        authProvider = result.provider.rawValue
        onAuthenticated()
    }
}

#Preview {
    AuthNameView(email: .constant(""), authProvider: .constant(""), onAuthenticated: {})
        .preferredColorScheme(.dark)
}
