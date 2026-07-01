//
//  TitleDetailsMediaRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsMediaRail: View {
    private enum Constants {
        static let screenshotLimit = 12
        static let trailerLimit = 8
        static let cardWidth: CGFloat = 260
        static let cardHeight: CGFloat = 146
        static let borderWidth: CGFloat = 1
        static let playSize: CGFloat = 46
    }

    let details: AnimeTitleDetails

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            screenshots
            trailers
        }
    }

    @ViewBuilder
    private var screenshots: some View {
        if !details.screenshots.isEmpty {
            mediaSection(title: StringResource.TitleDetails.screenshotsTitle) {
                ForEach(Array(details.screenshots.prefix(Constants.screenshotLimit).enumerated()), id: \.offset) { _, url in
                    mediaCard(url: url)
                }
            }
        }
    }

    @ViewBuilder
    private var trailers: some View {
        if !details.trailers.isEmpty {
            mediaSection(title: StringResource.TitleDetails.trailersTitle) {
                ForEach(details.trailers.prefix(Constants.trailerLimit)) { trailer in
                    mediaCard(url: trailer.coverURL, title: trailer.label ?? StringResource.TitleDetails.trailer, showsPlay: true)
                }
            }
        }
    }

    private func mediaSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: title)
                .padding(.horizontal, Spacing.ml)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: Spacing.md) {
                    content()
                }
                .padding(.horizontal, Spacing.ml)
                .padding(.vertical, Spacing.sm)
            }
        }
    }

    private func mediaCard(url: URL?, title: String? = nil, showsPlay: Bool = false) -> some View {
        ZStack(alignment: .bottomLeading) {
            HomeRemoteImage(url: url)

            LinearGradient(
                colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.78)
                ],
                startPoint: .center,
                endPoint: .bottom
            )

            if showsPlay {
                Circle()
                    .fill(Color.black.opacity(0.56))
                    .frame(width: Constants.playSize, height: Constants.playSize)
                    .overlay {
                        Image(systemName: "play.fill")
                            .font(Typography.headline)
                            .foregroundStyle(DesignTokens.Colors.text)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }

            if let title {
                Text(title)
                    .font(Typography.captionSemibold)
                    .foregroundStyle(DesignTokens.Colors.text)
                    .lineLimit(2)
                    .padding(Spacing.ms)
            }
        }
        .frame(width: Constants.cardWidth, height: Constants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
    }
}

extension AnimeTrailer {
    var coverURL: URL? {
        if let thumbnailURL {
            return thumbnailURL
        }

        guard provider == "youtube" else {
            return nil
        }

        return URL(string: "https://i.ytimg.com/vi/\(externalId)/hqdefault.jpg")
    }
}
