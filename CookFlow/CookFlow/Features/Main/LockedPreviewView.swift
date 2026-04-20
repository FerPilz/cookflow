import SwiftUI

struct LockedPreviewView: View {
    let lines: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let first = lines.first {
                Text(first)
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textCream)
            }

            if lines.count > 1 {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(Array(lines.dropFirst()), id: \.self) { line in
                        Text(line)
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    }
                }
                .blur(radius: 3)
                .overlay(alignment: .center) {
                    HStack(spacing: 6) {
                        Image(systemName: "lock.fill")
                        Text("Premium")
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(DesignSystem.Colors.backgroundNearBlack.opacity(0.9))
                    .clipShape(Capsule())
                }
            }
        }
        .padding(DesignSystem.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignSystem.Colors.backgroundNearBlack)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }
}

#Preview {
    LockedPreviewView(lines: [
        "Detected: Creamy Tomato Pasta",
        "1. 200g pasta",
        "2. 2 garlic cloves",
        "3. Simmer for 15 min"
    ])
    .padding()
    .background(DesignSystem.Colors.backgroundNearBlack)
    .preferredColorScheme(.dark)
}
