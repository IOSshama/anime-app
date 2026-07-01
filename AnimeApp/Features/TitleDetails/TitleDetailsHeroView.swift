//
//  TitleDetailsHeroView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsHeroView: View {
    private enum Constants {
        static let heroMinHeight: CGFloat = 700
        static let posterWidth: CGFloat = 202
        static let posterTopPadding: CGFloat = 76
        static let contentBottomPadding: CGFloat = Spacing.xl
        static let posterShadowRadius: CGFloat = 26
        static let posterShadowY: CGFloat = 18
        static let backgroundBlur: CGFloat = 36
        static let backgroundScale: CGFloat = 1.18
        static let titleLineLimit = 3
        static let originalLineLimit = 1
        static let genreLimit = 6
        static let badgePadding: CGFloat = Spacing.sm
        static let borderWidth: CGFloat = 1
        static let watchButtonHeight: CGFloat = 48
        static let actionBlockMaxWidth: CGFloat = 340
    }

    let details: AnimeTitleDetails

    var body: some View {
        VStack(spacing: Spacing.lg) {
            poster

            VStack(spacing: Spacing.md) {
                titleBlock
                metaBlock
                genreBlock
                actionBlock
            }
            .padding(.horizontal, Spacing.ml)
        }
        .padding(.top, Constants.posterTopPadding)
        .padding(.bottom, Constants.contentBottomPadding)
        .frame(maxWidth: .infinity)
        .frame(minHeight: Constants.heroMinHeight, alignment: .top)
        .background {
            GeometryReader { proxy in
                ambientBackground(height: proxy.size.height)
            }
        }
    }

    private func ambientBackground(height: CGFloat) -> some View {
        ZStack {
            HomeRemoteImage(url: details.title.bannerURL ?? details.title.posterURL)
                .frame(maxWidth: .infinity, maxHeight: height)
                .clipped()
                .blur(radius: Constants.backgroundBlur)
                .scaleEffect(Constants.backgroundScale)
                .opacity(0.70)

            LinearGradient(
                colors: [
                    Color.black.opacity(0.38),
                    DesignTokens.Colors.background.opacity(0.56),
                    DesignTokens.Colors.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .clipped()
    }

    private var poster: some View {
        ZStack(alignment: .topLeading) {
            HomeRemoteImage(url: details.title.posterURL)
                .frame(
                    width: Constants.posterWidth,
                    height: Constants.posterWidth / DesignTokens.Poster.aspectRatio
                )
                .clipped()

            if let rating = details.title.rating, details.title.status != .announced {
                RatingBadge(score: rating)
                    .padding(Constants.badgePadding)
            } else if details.title.status == .announced {
                StatusPill(kind: .announced)
                    .padding(Constants.badgePadding)
            }
        }
        .frame(
            width: Constants.posterWidth,
            height: Constants.posterWidth / DesignTokens.Poster.aspectRatio
        )
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineStrong, lineWidth: Constants.borderWidth)
        }
        .shadow(color: DesignTokens.Shadow.large, radius: Constants.posterShadowRadius, x: Spacing.zero, y: Constants.posterShadowY)
    }

    private var titleBlock: some View {
        VStack(spacing: Spacing.xs) {
            Text(details.title.titleRu)
                .font(Typography.display)
                .foregroundStyle(DesignTokens.Colors.text)
                .multilineTextAlignment(.center)
                .lineLimit(Constants.titleLineLimit)

            if let originalTitle = details.title.titleOriginal ?? details.title.titleEn, !originalTitle.isEmpty {
                Text(originalTitle)
                    .font(Typography.subheadline)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
                    .lineLimit(Constants.originalLineLimit)
            }
        }
    }

    private var metaBlock: some View {
        VStack(spacing: Spacing.xs) {
            Text(TitleDetailsMetaText.primaryMeta(for: details))
                .font(Typography.subheadlineSemibold)
                .foregroundStyle(DesignTokens.Colors.textBody)
                .multilineTextAlignment(.center)

            HStack(spacing: Spacing.sm) {
                StatusPill(kind: details.title.status.detailsPillKind)

                if details.sequelAnnounced {
                    StatusPill(kind: .planned)
                }
            }
        }
    }

    @ViewBuilder
    private var genreBlock: some View {
        if !details.title.genres.isEmpty {
            FlowLayout(spacing: Spacing.sm, rowSpacing: Spacing.sm) {
                ForEach(details.title.genres.prefix(Constants.genreLimit)) { genre in
                    Text(genre.name)
                        .font(Typography.captionSemibold)
                        .foregroundStyle(DesignTokens.Colors.textBody)
                        .padding(.horizontal, Spacing.ms)
                        .padding(.vertical, Spacing.sm)
                        .glassSurface(style: .regular, radius: CornerRadius.full)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var actionBlock: some View {
        HStack(spacing: Spacing.sm) {
            if details.title.hasCustomPlayer {
                NavigationLink(value: AppRoute.player(titleId: details.id, episodeId: nil)) {
                    Label(StringResource.DesignSystem.watch, systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(AnimeButtonStyle(variant: .primary, height: Constants.watchButtonHeight, radius: CornerRadius.full))
            } else {
                Label(StringResource.TitleDetails.videoUnavailable, systemImage: "play.slash")
                    .font(Typography.button)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
                    .frame(maxWidth: .infinity)
                    .frame(height: Constants.watchButtonHeight)
                    .glassSurface(style: .regular, radius: CornerRadius.full)
            }

            Button {
            } label: {
                Image(systemName: "bookmark")
                    .font(Typography.headline)
                    .frame(width: Constants.watchButtonHeight, height: Constants.watchButtonHeight)
            }
            .buttonStyle(.plain)
            .foregroundStyle(DesignTokens.Colors.text)
            .glassSurface(style: .strong, radius: CornerRadius.full)
            .accessibilityLabel(StringResource.DesignSystem.watchLater)
        }
        .padding(.top, Spacing.xs)
        .frame(maxWidth: Constants.actionBlockMaxWidth)
    }
}

private extension AnimeStatus {
    var detailsPillKind: StatusPill.Kind {
        switch self {
        case .announced:
            .announced
        case .ongoing:
            .ongoing
        case .released:
            .released
        case .unknown:
            .released
        }
    }
}
