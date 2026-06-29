//
//  PosterPlaceholder.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct PosterPlaceholder: View {
    private enum Constants {
        static let iconSize: CGFloat = 34
        static let titleHorizontalPadding: CGFloat = Spacing.ms
        static let borderWidth: CGFloat = 1
        static let previewWidth: CGFloat = 160
    }

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

            VStack(spacing: Spacing.sm) {
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: Constants.iconSize, weight: .semibold))
                    .foregroundStyle(DesignTokens.Colors.primaryLink)

                if let title {
                    Text(title)
                        .font(Typography.captionSemibold)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, Constants.titleHorizontalPadding)
                }
            }
        }
        .aspectRatio(DesignTokens.Poster.aspectRatio, contentMode: .fit)
        .overlay {
            RoundedRectangle(cornerRadius: DesignTokens.Poster.cornerRadius, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
        .accessibilityHidden(title == nil)
        .accessibilityLabel(title ?? "")
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        PosterPlaceholder(title: StringResource.DesignSystem.sampleAnimeTitle)
            .frame(width: PosterPlaceholderPreviewConstants.width)
    }
}

private enum PosterPlaceholderPreviewConstants {
    static let width: CGFloat = 160
}
