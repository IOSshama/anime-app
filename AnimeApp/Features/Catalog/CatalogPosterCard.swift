//
//  CatalogPosterCard.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct CatalogPosterCard: View {
    private enum Constants {
        static let titleLineLimit = 2
        static let metaLineLimit = 1
        static let genreLimit = 2
        static let metaHeight: CGFloat = 18
        static let textSpacing: CGFloat = Spacing.xs
        static let badgePadding: CGFloat = Spacing.sm
        static let borderWidth: CGFloat = 1
        static let shadowRadius: CGFloat = 16
        static let shadowY: CGFloat = 8
    }

    let title: AnimeTitle
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: Constants.textSpacing) {
                poster

                Text(title.titleRu)
                    .font(Typography.subheadlineSemibold)
                    .foregroundStyle(DesignTokens.Colors.textStrong)
                    .lineLimit(Constants.titleLineLimit)
                    .frame(maxWidth: .infinity, alignment: .topLeading)

                Text(HomeMetaText.titleMeta(for: title))
                    .font(Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
                    .lineLimit(Constants.metaLineLimit)
                    .frame(height: Constants.metaHeight, alignment: .topLeading)

                if !title.genres.isEmpty {
                    Text(title.genres.prefix(Constants.genreLimit).map(\.name).joined(separator: ", "))
                        .font(Typography.caption)
                        .foregroundStyle(DesignTokens.Colors.textFaint)
                        .lineLimit(Constants.metaLineLimit)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }

    private var poster: some View {
        ZStack(alignment: .topLeading) {
            HomeRemoteImage(url: title.posterURL)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            LinearGradient(
                colors: [
                    Color.black.opacity(0.18),
                    Color.black.opacity(0)
                ],
                startPoint: .top,
                endPoint: .center
            )
        }
        .aspectRatio(DesignTokens.Poster.aspectRatio, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        .overlay(alignment: .topLeading) {
            badge
                .padding(Constants.badgePadding)
        }
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
        .shadow(color: DesignTokens.Shadow.medium, radius: Constants.shadowRadius, x: Spacing.zero, y: Constants.shadowY)
    }

    @ViewBuilder
    private var badge: some View {
        if let rating = title.rating, title.status != .announced {
            RatingBadge(score: rating)
        } else if title.status == .announced {
            StatusPill(kind: .announced)
        }
    }
}
