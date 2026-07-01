//
//  TitleDetailsRelatedSection.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsRelatedSection: View {
    private enum Constants {
        static let maxRows = 6
    }

    let details: AnimeTitleDetails

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            franchiseSection
            relatedSection
        }
    }

    @ViewBuilder
    private var franchiseSection: some View {
        if !details.franchiseSeasons.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                SectionHeader(title: StringResource.TitleDetails.franchiseTitle)

                VStack(spacing: Spacing.sm) {
                    ForEach(details.franchiseSeasons.prefix(Constants.maxRows)) { season in
                        NavigationLink(value: AppRoute.titleDetails(id: season.id)) {
                            row(
                                title: season.title,
                                subtitle: season.year.map(String.init),
                                isCurrent: season.isCurrent
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var relatedSection: some View {
        if !details.related.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                SectionHeader(title: StringResource.TitleDetails.relatedTitle)

                VStack(spacing: Spacing.sm) {
                    ForEach(details.related.prefix(Constants.maxRows)) { related in
                        NavigationLink(value: AppRoute.titleDetails(id: related.id)) {
                            row(
                                title: related.title,
                                subtitle: related.relation ?? related.year.map(String.init),
                                isCurrent: false
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func row(title: String, subtitle: String?, isCurrent: Bool) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: isCurrent ? "checkmark.circle.fill" : "film.stack")
                .font(Typography.headline)
                .foregroundStyle(isCurrent ? DesignTokens.Colors.primaryLink : DesignTokens.Colors.textMuted)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .font(Typography.bodySemibold)
                    .foregroundStyle(DesignTokens.Colors.text)
                    .lineLimit(2)

                if let subtitle {
                    Text(subtitle)
                        .font(Typography.caption)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                }
            }

            Spacer(minLength: Spacing.sm)

            Image(systemName: "chevron.right")
                .font(Typography.captionSemibold)
                .foregroundStyle(DesignTokens.Colors.textFaint)
        }
        .padding(Spacing.ms)
        .glassSurface(style: .regular, radius: CornerRadius.md)
    }
}
