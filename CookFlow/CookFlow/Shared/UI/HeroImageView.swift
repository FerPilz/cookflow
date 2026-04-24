import SwiftUI
import UIKit

struct HeroImageView: View {
    let imageName: String
    var contentMode: ContentMode = .fill

    var body: some View {
        ZStack {
            if let embeddedImage = embeddedImage {
                Image(uiImage: embeddedImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else if !imageName.isEmpty, UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                LinearGradient(
                    colors: [DesignSystem.Colors.card, DesignSystem.Colors.secondaryBackground],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
            }
        }
    }

    private var embeddedImage: UIImage? {
        guard imageName.hasPrefix("base64:") else { return nil }
        let raw = String(imageName.dropFirst("base64:".count))
        guard let data = Data(base64Encoded: raw) else { return nil }
        return UIImage(data: data)
    }
}

#Preview {
    HeroImageView(imageName: "")
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .padding()
        .background(DesignSystem.Colors.background)
        .preferredColorScheme(.light)
}
