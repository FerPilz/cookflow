//
//  AuthNameView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct AuthNameView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var authProvider: String

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("Tell us who you are")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            InputField(label: "Name", placeholder: "Your name", text: $name)
            InputField(label: "Email", placeholder: "you@email.com", text: $email)

            Text("Auth provider: \(authProvider.isEmpty ? "Not selected" : authProvider)")
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
        .padding(.horizontal, DesignSystem.Spacing.xl)
    }
}

#Preview {
    AuthNameView(name: .constant(""), email: .constant(""), authProvider: .constant(""))
}
