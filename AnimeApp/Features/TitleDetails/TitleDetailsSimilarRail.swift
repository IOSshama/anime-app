//
//  TitleDetailsSimilarRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsSimilarRail: View {
    private enum Constants {
        static let maxItems = 18
    }

    let titles: [AnimeTitle]

    var body: some View {
        if !titles.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                SectionHeader(title: StringResource.TitleDetails.similarTitle)
                    .padding(.horizontal, Spacing.ml)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: Spacing.md) {
                        ForEach(titles.prefix(Constants.maxItems)) { title in
                            NavigationLink(value: AppRoute.titleDetails(id: title.id)) {
                                SimilarPosterCard(title: title)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, Spacing.ml)
                    .padding(.vertical, Spacing.sm)
                }
            }
        }
    }
}

private struct SimilarPosterCard: View {
    private enum Constants {
        static let width: CGFloat = 150
        static let titleLineLimit = 2
        static let metaLineLimit = 1
        static let badgePadding: CGFloat = Spacing.sm
        static let borderWidth: CGFloat = 1
        static let shadowRadius: CGFloat = 16
        static let shadowY: CGFloat = 8
    }

    let title: AnimeTitle

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            poster

            Text(title.titleRu)
                .font(Typography.captionSemibold)
                .foregroundStyle(DesignTokens.Colors.text)
                .lineLimit(Constants.titleLineLimit)

            Text(HomeMetaText.cardMeta(for: title))
                .font(Typography.caption)
                .foregroundStyle(DesignTokens.Colors.textMuted)
                .lineLimit(Constants.metaLineLimit)
        }
        .frame(width: Constants.width, alignment: .leading)
    }

    private var poster: some View {
        ZStack(alignment: .topLeading) {
            HomeRemoteImage(url: title.posterURL)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            if let rating = title.rating, title.status != .announced {
                RatingBadge(score: rating)
                    .padding(Constants.badgePadding)
            }
        }
        .aspectRatio(DesignTokens.Poster.aspectRatio, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
        .shadow(color: DesignTokens.Shadow.medium, radius: Constants.shadowRadius, x: Spacing.zero, y: Constants.shadowY)
    }
}
