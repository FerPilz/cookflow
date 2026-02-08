//
//  AppleSignInCoordinator.swift
//  CookFlow
//
//  Created by Codex on 2/3/26.
//

import AuthenticationServices
import Foundation
import UIKit

@MainActor
final class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let nameFormatter = PersonNameComponentsFormatter()
    private var continuation: CheckedContinuation<AuthResult, Error>?

    func signIn() async throws -> AuthResult {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.presentationContextProvider = self
            controller.performRequests()
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        AuthPresentationHelper.keyWindow() ?? UIWindow()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            continuation?.resume(throwing: AuthError.unknown)
            continuation = nil
            return
        }

        let displayName = credential.fullName.flatMap { nameFormatter.string(from: $0) }
        let result = AuthResult(provider: .apple, displayName: displayName, email: credential.email)
        continuation?.resume(returning: result)
        continuation = nil
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
