//
//  GoogleSignInCoordinator.swift
//  CookFlow
//
//  Created by Codex on 2/3/26.
//

import Foundation
import UIKit

#if canImport(GoogleSignIn)
import GoogleSignIn
#endif

@MainActor
final class GoogleSignInCoordinator {
    func signIn() async throws -> AuthResult {
        #if canImport(GoogleSignIn)
        guard let presenting = AuthPresentationHelper.topViewController() else {
            throw AuthError.missingPresentationAnchor
        }
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
