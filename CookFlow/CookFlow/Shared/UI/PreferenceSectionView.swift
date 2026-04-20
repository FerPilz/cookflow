import SwiftUI

struct PreferenceSectionView<Content: View>: View {
    let title: String
    let subtitle: String?
    @ViewBuilder let content: Content

    init(title: String, subtitle: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .center, spacing: DesignSystem.Spacing.xs) {
            Text(title)
                .font(DesignSystem.Fonts.body)
                .fontWeight(.semibold)
                .foregroundColor(DesignSystem.Colors.textCream)
                .padding(.top, DesignSystem.Spacing.xs)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            if let subtitle {
                Text(subtitle)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }

            content
        }
    }
}

#Preview {
    PreferenceSectionView(title: "Food Style Preference") {
        Text("Content")
            .foregroundColor(DesignSystem.Colors.textCream)
    }
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
