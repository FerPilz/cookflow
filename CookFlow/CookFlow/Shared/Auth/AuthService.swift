//
//  AuthService.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import Foundation
import UIKit

enum AuthProvider: String {
    case guest
    case email
    case apple
    case google
}

struct AuthResult {
    let provider: AuthProvider
    let displayName: String?
    let email: String?
}

enum AuthError: LocalizedError {
    case missingPresentationAnchor
    case missingGoogleClientID
    case googleSignInUnavailable
    case unknown

    var errorDescription: String? {
        switch self {
        case .missingPresentationAnchor:
            return "Unable to find a presentation anchor."
        case .missingGoogleClientID:
            return "Missing GIDClientID in Info.plist."
        case .googleSignInUnavailable:
            return "GoogleSignIn SDK not available."
        case .unknown:
            return "Unknown authentication error."
        }
    }
}

@MainActor
protocol AuthServicing {
    func signInWithApple() async throws -> AuthResult
    func signInWithGoogle() async throws -> AuthResult
}

@MainActor
final class AuthService: NSObject, AuthServicing {
    static let shared = AuthService()

    func signInGuest() async -> AuthResult {
        AuthResult(provider: .guest, displayName: "Guest", email: nil)
    }

    func signInEmail(email: String) async -> AuthResult {
        AuthResult(provider: .email, displayName: nil, email: email)
    }

    func signInWithApple() async throws -> AuthResult {
        try await AppleSignInCoordinator().signIn()
    }

    func signInWithGoogle() async throws -> AuthResult {
        try await GoogleSignInCoordinator().signIn()
    }
}
