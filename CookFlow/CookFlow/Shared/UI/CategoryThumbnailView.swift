import SwiftUI
import UIKit

struct CategoryThumbnailView: View {
    enum Presentation {
        case roundedRectangle
        case circle
    }

    let imageName: String?
    let size: CGFloat
    let systemImageName: String
    let presentation: Presentation

    init(
        imageName: String?,
        size: CGFloat = 60,
        systemImageName: String = "fork.knife",
        presentation: Presentation = .roundedRectangle
    ) {
        self.imageName = imageName
        self.size = size
        self.systemImageName = systemImageName
        self.presentation = presentation
    }

    var body: some View {
        switch presentation {
        case .roundedRectangle:
            roundedRectangleBody
        case .circle:
            circleBody
        }
    }

    private var roundedRectangleBody: some View {
        content
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider.opacity(0.55), lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }

    private var circleBody: some View {
        content
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(DesignSystem.Colors.divider.opacity(0.55), lineWidth: 1)
            }
    }

    private var content: some View {
        ZStack {
            if let imageName, !imageName.isEmpty, UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            } else {
                fallbackBackground
                    .overlay {
                        Image(systemName: systemImageName)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(DesignSystem.Colors.textCream.opacity(0.8))
                    }
            }
        }
    }

    @ViewBuilder
    private var fallbackBackground: some View {
        switch presentation {
        case .roundedRectangle:
            RoundedRectangle(cornerRadius: DesignSystem.Radius.imageCard, style: .continuous)
                .fill(DesignSystem.Gradients.imageFallback)
        case .circle:
            Circle()
                .fill(DesignSystem.Gradients.imageFallback)
        }
    }
}

#Preview {
    CategoryThumbnailView(imageName: nil, presentation: .circle)
        .padding()
        .background(DesignSystem.Colors.background)
        .preferredColorScheme(.light)
}
