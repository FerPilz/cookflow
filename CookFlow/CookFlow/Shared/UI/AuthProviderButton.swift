import SwiftUI
import UIKit

struct AuthProviderButton: View {
    let title: String
    let icon: Icon
    let action: () -> Void

    enum Icon {
        case apple
        case google
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                iconView
                    .frame(width: 20, height: 20)

                Text(title)
                    .font(DesignSystem.Fonts.link)
                    .foregroundColor(DesignSystem.Colors.textCream)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, DesignSystem.Spacing.md)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .apple:
            Image(systemName: "applelogo")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(DesignSystem.Colors.textCream)
        case .google:
            if UIImage(named: "google_g") != nil {
                Image("google_g")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
            } else if UIImage(named: "GoogleLogo") != nil {
                Image("GoogleLogo")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
            } else {
                Text("G")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .frame(width: 20, height: 20)
                    .background(DesignSystem.Colors.backgroundNearBlack)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    VStack(spacing: DesignSystem.Spacing.sm) {
        AuthProviderButton(title: "Continue with Apple", icon: .apple, action: {})
        AuthProviderButton(title: "Continue with Google", icon: .google, action: {})
    }
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
