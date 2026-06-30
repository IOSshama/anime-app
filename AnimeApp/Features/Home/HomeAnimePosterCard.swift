//
//  HomeAnimePosterCard.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeAnimePosterCard: View {
    private enum Constants {
        static let width: CGFloat = 150
        static let posterHeight: CGFloat = 214
        static let titleHeight: CGFloat = 40
        static let titleLineLimit = 2
        static let genreLimit = 2
        static let badgePadding: CGFloat = Spacing.sm
        static let shadowRadius: CGFloat = 16
        static let shadowY: CGFloat = 8
        static let borderWidth: CGFloat = 1
    }

    let title: AnimeTitle
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                poster

                Text(title.titleRu)
                    .font(Typography.captionSemibold)
                    .foregroundStyle(DesignTokens.Colors.text)
                    .lineLimit(Constants.titleLineLimit)
                    .frame(height: Constants.titleHeight, alignment: .topLeading)
            }
            .frame(width: Constants.width, alignment: .leading)
        }
        .buttonStyle(.plain)
    }

    private var poster: some View {
        ZStack(alignment: .bottomLeading) {
            HomeRemoteImage(url: title.posterURL)

            LinearGradient(
                colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.30),
                    Color.black.opacity(0.86)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: Spacing.xs) {
                let meta = HomeMetaText.cardMeta(for: title)
                if !meta.isEmpty {
                    Text(meta)
                        .font(Typography.captionSemibold)
                        .foregroundStyle(DesignTokens.Colors.textBody)
                }

                if !title.genres.isEmpty {
                    Text(title.genres.prefix(Constants.genreLimit).map(\.name).joined(separator: ", "))
                        .font(Typography.caption)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                        .lineLimit(1)
                }
            }
            .padding(Spacing.ms)
        }
        .frame(width: Constants.width, height: Constants.posterHeight)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        .overlay(alignment: .topLeading) {
            if let rating = title.rating, title.status != .announced {
                RatingBadge(score: rating)
                    .padding(Constants.badgePadding)
            } else if title.status == .announced {
                StatusPill(kind: .announced)
                    .padding(Constants.badgePadding)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
        .shadow(color: DesignTokens.Shadow.medium, radius: Constants.shadowRadius, x: Spacing.zero, y: Constants.shadowY)
    }
}
