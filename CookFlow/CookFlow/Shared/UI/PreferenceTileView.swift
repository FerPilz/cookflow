import SwiftUI

struct PreferenceTileView: View {
    let title: String
    let isSelected: Bool
    var fixedHeight: CGFloat = 80
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .fill(tileFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                            .stroke(tileBorder, lineWidth: isSelected ? 2 : 1)
                    )

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.backgroundNearBlack)
                        .padding(8)
                }

                Text(title)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(isSelected ? DesignSystem.Colors.backgroundNearBlack : DesignSystem.Colors.textCream)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.vertical, DesignSystem.Spacing.xs)
                    .padding(.horizontal, DesignSystem.Spacing.sm)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(height: fixedHeight)
        }
        .buttonStyle(.plain)
    }

    private var tileFill: Color {
        isSelected ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.card
    }

    private var tileBorder: Color {
        isSelected ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.divider
    }
}

#Preview {
    HStack(spacing: DesignSystem.Spacing.sm) {
        PreferenceTileView(title: "Vegetarian", isSelected: false, onTap: {})
        PreferenceTileView(title: "Protein Intake", isSelected: true, onTap: {})
    }
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
