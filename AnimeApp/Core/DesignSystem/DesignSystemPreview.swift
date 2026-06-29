//
//  DesignSystemPreview.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct DesignSystemPreview: View {
    private enum Constants {
        static let posterPreviewWidth: CGFloat = 150
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                SectionHeader(
                    title: StringResource.DesignSystem.previewTitle,
                    subtitle: StringResource.DesignSystem.previewSubtitle
                )

                GlassSurface {
                    VStack(alignment: .leading, spacing: Spacing.ms) {
                        Text(StringResource.DesignSystem.glassTitle)
                            .font(Typography.headline)
                            .foregroundStyle(DesignTokens.Colors.text)

                        Text(StringResource.DesignSystem.glassSubtitle)
                            .font(Typography.subheadline)
                            .foregroundStyle(DesignTokens.Colors.textMuted)
                    }
                    .padding(Spacing.ml)
                }

                HStack {
                    Button(StringResource.DesignSystem.watch) {}
                        .buttonStyle(AnimeButtonStyle(variant: .primary))

                    IconGlassButton(systemName: "bookmark", accessibilityLabel: StringResource.DesignSystem.watchLater) {}
                    IconGlassButton(systemName: "star.fill", accessibilityLabel: StringResource.DesignSystem.rate, isActive: true) {}
                }

                HStack {
                    RatingBadge(score: 8.4)
                    StatusPill(kind: .ongoing)
                    StatusPill(kind: .planned)
                }

                HStack {
                    FilterChip(title: StringResource.DesignSystem.sampleOngoing, isSelected: true) {}
                    FilterChip(title: StringResource.DesignSystem.sampleAction, isSelected: true, role: .include) {}
                    FilterChip(title: StringResource.DesignSystem.sampleHorror, isSelected: true, role: .exclude) {}
                }

                PosterPlaceholder(title: StringResource.DesignSystem.poster)
                    .frame(width: Constants.posterPreviewWidth)
            }
            .padding(Spacing.ml)
        }
        .animeScreenBackground()
    }
}

#Preview {
    DesignSystemPreview()
}
