import SwiftUI

struct PosterPlaceholder: View {
    var title: String?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DesignTokens.Poster.cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            DesignTokens.Colors.elevated,
                            DesignTokens.Colors.surface,
                            DesignTokens.Colors.primary.opacity(0.18)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(spacing: 8) {
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(DesignTokens.Colors.primaryLink)

                if let title {
                    Text(title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 12)
                }
            }
        }
        .aspectRatio(DesignTokens.Poster.aspectRatio, contentMode: .fit)
        .overlay {
            RoundedRectangle(cornerRadius: DesignTokens.Poster.cornerRadius, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: 1)
        }
        .accessibilityHidden(title == nil)
        .accessibilityLabel(title ?? "")
    }
}

#Preview("Poster Placeholder") {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        PosterPlaceholder(title: "Название аниме")
            .frame(width: 160)
    }
}
