import SwiftUI

struct ScrollProgressBar: View {
    let progress: CGFloat

    private let trackHeight: CGFloat = 120
    private let trackWidth: CGFloat = 6
    private let thumbSize: CGFloat = 12

    var body: some View {
        let clampedProgress = min(max(progress, 0), 1)
        let travel = trackHeight - thumbSize
        let thumbOffset = (clampedProgress * travel) - (travel / 2)

        ZStack(alignment: .center) {
            Capsule()
                .fill(DesignSystem.Colors.textMuted.opacity(0.3))
                .frame(width: trackWidth, height: trackHeight)

            VStack(spacing: 0) {
                Spacer(minLength: 0)
                    .frame(height: trackHeight * (1 - clampedProgress))
                Capsule()
                    .fill(DesignSystem.Colors.ctaGreen)
                    .frame(width: trackWidth, height: trackHeight * clampedProgress)
            }
            .frame(width: trackWidth, height: trackHeight)

            Circle()
                .fill(DesignSystem.Colors.ctaGreen)
                .frame(width: thumbSize, height: thumbSize)
                .offset(y: thumbOffset)
        }
        .frame(width: 24, height: trackHeight)
    }
}

#Preview {
    ScrollProgressBar(progress: 0.45)
        .padding()
        .background(DesignSystem.Colors.backgroundNearBlack)
        .preferredColorScheme(.dark)
}
