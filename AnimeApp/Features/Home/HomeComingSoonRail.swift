//
//  HomeComingSoonRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeComingSoonRail: View {
    private enum Constants {
        static let maxItems = 12
        static let cardWidth: CGFloat = 250
        static let imageHeight: CGFloat = 140
        static let titleLineLimit = 2
        static let borderWidth: CGFloat = 1
    }

    let items: [UpcomingTitle]

    var body: some View {
        if !items.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HomeRailHeader(title: StringResource.Home.comingSoon, showAll: false)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: Spacing.md) {
                        ForEach(items.prefix(Constants.maxItems)) { item in
                            card(item)
                        }
                    }
                    .padding(.horizontal, Spacing.ml)
                    .padding(.vertical, Spacing.sm)
                }
            }
        }
    }

    private func card(_ item: UpcomingTitle) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            ZStack(alignment: .center) {
                HomeRemoteImage(url: item.thumbnailURL)

                Circle()
                    .fill(Color.black.opacity(0.62))
                    .frame(width: Spacing.xxl, height: Spacing.xxl)

                Image(systemName: "play.fill")
                    .font(Typography.headline)
                    .foregroundStyle(DesignTokens.Colors.text)
            }
            .frame(width: Constants.cardWidth, height: Constants.imageHeight)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                    .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
            }

            Text(item.title)
                .font(Typography.captionSemibold)
                .foregroundStyle(DesignTokens.Colors.text)
                .lineLimit(Constants.titleLineLimit)

            Text(item.year.map(String.init) ?? StringResource.Home.noPoster)
                .font(Typography.caption)
                .foregroundStyle(DesignTokens.Colors.textMuted)
        }
        .frame(width: Constants.cardWidth, alignment: .leading)
    }
}
