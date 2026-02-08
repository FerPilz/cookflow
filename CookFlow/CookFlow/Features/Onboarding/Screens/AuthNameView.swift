//
//  AuthNameView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import AuthenticationServices
import SwiftUI

struct AuthNameView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var authProvider: String

    @State private var statusMessage: String?
    @State private var errorMessage: String?
    @State private var isSigningIn = false

    var body: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.md) {
                Text("Tell us who you are")
                    .font(DesignSystem.Fonts.screenTitle)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)

                VStack(spacing: DesignSystem.Spacing.md) {
                    InputField(label: "Name", placeholder: "Your name", text: $name)
                    InputField(label: "Email", placeholder: "you@email.com", text: $email)
                }

                HStack(spacing: DesignSystem.Spacing.sm) {
                    Rectangle()
                        .fill(DesignSystem.Colors.divider)
                        .frame(height: 1)
                    Text("or")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                    Rectangle()
                        .fill(DesignSystem.Colors.divider)
                        .frame(height: 1)
                }

                VStack(spacing: DesignSystem.Spacing.sm) {
                    Button(action: { Task { await signInWithApple() } }) {
                        SignInWithAppleButton(.continue) { _ in } onCompletion: { _ in }
                            .signInWithAppleButtonStyle(.black)
                            .frame(height: 56)
                            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard))
                            .allowsHitTesting(false)
                    }
                    .buttonStyle(.plain)
                    .disabled(isSigningIn)

                    Button(action: { Task { await signInWithGoogle() } }) {
                        HStack(spacing: DesignSystem.Spacing.xs) {
                            Text("Continue with Google")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(DesignSystem.Colors.textCream)
                            Image(systemName: "g.circle.fill")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(DesignSystem.Colors.textCream)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(DesignSystem.Colors.backgroundNearBlack)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard))
                        .overlay(
                            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard)
                                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                    .disabled(isSigningIn)
                }

                if let statusMessage {
                    Text(statusMessage)
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }

                if let errorMessage {
                    Text("Error: \(errorMessage)")
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(Color.red.opacity(0.8))
                }

                Text("Auth provider: \(authProvider.isEmpty ? "Not selected" : authProvider)")
                    .font(DesignSystem.Fonts.body)
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
            .padding(.horizontal, DesignSystem.Spacing.xl)
            .padding(.vertical, DesignSystem.Spacing.sm)
        }
    }

    @MainActor
    private func signInWithApple() async {
        isSigningIn = true
        defer { isSigningIn = false }
        errorMessage = nil
        authProvider = "apple"

        do {
            let result = try await AuthService.shared.signInWithApple()
            applyAuthResult(result)
            statusMessage = "Signed in with Apple"
        } catch {
            statusMessage = nil
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
    }

    @MainActor
    private func signInWithGoogle() async {
        isSigningIn = true
        defer { isSigningIn = false }
        errorMessage = nil
        authProvider = "google"

        do {
            let result = try await AuthService.shared.signInWithGoogle()
            applyAuthResult(result)
            statusMessage = "Signed in with Google"
        } catch {
            statusMessage = nil
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
    }

    private func applyAuthResult(_ result: AuthResult) {
        if let displayName = result.displayName, !displayName.isEmpty {
            name = displayName
        }
        if let emailValue = result.email, !emailValue.isEmpty {
            email = emailValue
        }
        authProvider = result.provider.rawValue
    }
}

#Preview {
    AuthNameView(name: .constant(""), email: .constant(""), authProvider: .constant(""))
    .preferredColorScheme(.dark)
}
