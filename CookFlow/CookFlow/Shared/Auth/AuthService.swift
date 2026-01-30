//
//  AuthService.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import AuthenticationServices
import Foundation
import ObjectiveC
import UIKit

#if canImport(GoogleSignIn)
import GoogleSignIn
#endif

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

enum AuthError: Error {
    case missingPresentationAnchor
    case missingGoogleClientID
    case googleSignInUnavailable
    case unknown
}

@MainActor
protocol AuthServicing {
    func signInGuest() async -> AuthResult
    func signInEmail(email: String) async -> AuthResult
    func signInApple() async throws -> AuthResult
    func signInGoogle(presenting: UIViewController) async throws -> AuthResult
}

@MainActor
final class AuthService: NSObject, AuthServicing {
    func signInGuest() async -> AuthResult {
        AuthResult(provider: .guest, displayName: "Guest", email: nil)
    }

    func signInEmail(email: String) async -> AuthResult {
        AuthResult(provider: .email, displayName: nil, email: email)
    }

    func signInApple() async throws -> AuthResult {
        try await withCheckedThrowingContinuation { continuation in
            let coordinator = AppleSignInCoordinator(continuation: continuation)
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = coordinator
            controller.presentationContextProvider = coordinator
            coordinator.attach(to: controller)
            controller.performRequests()
        }
    }

    func signInGoogle(presenting: UIViewController) async throws -> AuthResult {
        #if canImport(GoogleSignIn)
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String,
              !clientID.isEmpty else {
            throw AuthError.missingGoogleClientID
        }

        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presenting)
        let profile = result.user.profile

        return AuthResult(
            provider: .google,
            displayName: profile?.name,
            email: profile?.email
        )
        #else
        throw AuthError.googleSignInUnavailable
        #endif
    }
}

@MainActor
private final class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let continuation: CheckedContinuation<AuthResult, Error>
    private let nameFormatter = PersonNameComponentsFormatter()

    init(continuation: CheckedContinuation<AuthResult, Error>) {
        self.continuation = continuation
    }

    func attach(to controller: ASAuthorizationController) {
        objc_setAssociatedObject(
            controller,
            &AssociatedKeys.coordinatorKey,
            self,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return UIWindow()
        }
        return window
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let displayName = credential.fullName.flatMap { nameFormatter.string(from: $0) }
            let result = AuthResult(provider: .apple, displayName: displayName, email: credential.email)
            continuation.resume(returning: result)
        } else {
            continuation.resume(throwing: AuthError.unknown)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation.resume(throwing: error)
    }

    private enum AssociatedKeys {
        static var coordinatorKey = "AppleSignInCoordinatorKey"
    }
}
