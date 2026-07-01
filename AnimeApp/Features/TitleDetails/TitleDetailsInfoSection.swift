//
//  TitleDetailsInfoSection.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsInfoSection: View {
    private enum Constants {
        static let columnSpacing: CGFloat = Spacing.ms
        static let rowSpacing: CGFloat = Spacing.ms
    }

    let details: AnimeTitleDetails

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: Constants.rowSpacing) {
            if let studio = TitleDetailsMetaText.studiosText(for: details.title) {
                infoCard(title: StringResource.TitleDetails.studio, value: studio, systemImage: "building.2")
            }

            if let nextEpisodeAt = details.nextEpisodeAt {
                infoCard(
                    title: StringResource.TitleDetails.nextEpisode,
                    value: nextEpisodeAt.formatted(date: .abbreviated, time: .shortened),
                    systemImage: "clock"
                )
            }

            infoCard(
                title: StringResource.TitleDetails.charactersTitle,
                value: String(details.characters.count),
                systemImage: "person.2"
            )

            infoCard(
                title: StringResource.TitleDetails.similarTitle,
                value: String(details.similar.count),
                systemImage: "square.grid.2x2"
            )
        }
    }

    private var columns: [GridItem] {
        [
            GridItem(.flexible(), spacing: Constants.columnSpacing),
            GridItem(.flexible(), spacing: Constants.columnSpacing)
        ]
    }

    private func infoCard(title: String, value: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Image(systemName: systemImage)
                .font(Typography.captionSemibold)
                .foregroundStyle(DesignTokens.Colors.primaryLink)

            Text(value)
                .font(Typography.bodySemibold)
                .foregroundStyle(DesignTokens.Colors.text)
                .lineLimit(2)

            Text(title)
                .font(Typography.caption)
                .foregroundStyle(DesignTokens.Colors.textMuted)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.ms)
        .glassSurface(style: .regular, radius: CornerRadius.md)
    }
}
