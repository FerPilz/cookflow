import SwiftUI

struct AIFeatureCard<Content: View>: View {
    let title: String
    let description: String
    let systemImage: String
    let ctaTitle: String
    let onTapCTA: () -> Void
    @ViewBuilder let content: Content

    init(
        title: String,
        description: String,
        systemImage: String,
        ctaTitle: String,
        onTapCTA: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.description = description
        self.systemImage = systemImage
        self.ctaTitle = ctaTitle
        self.onTapCTA = onTapCTA
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.ctaGreen)
                    .frame(width: 32, height: 32)
                    .background(DesignSystem.Colors.backgroundNearBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(DesignSystem.Fonts.subtitle)
                        .foregroundColor(DesignSystem.Colors.textCream)

                    Text(description)
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
            }

            content

            Button(action: onTapCTA) {
                Text(ctaTitle)
                    .font(DesignSystem.Fonts.link)
                    .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(DesignSystem.Colors.ctaGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .padding(DesignSystem.Spacing.md)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview {
    AIFeatureCard(
        title: "Web Recipe Import",
        description: "Paste a URL for instant extraction preview.",
        systemImage: "link",
        ctaTitle: "Import Full Recipe",
        onTapCTA: {}
    ) {
        Text("Preview block")
            .font(DesignSystem.Fonts.valueProp)
            .foregroundColor(DesignSystem.Colors.textMuted)
    }
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
