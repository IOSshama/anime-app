//
//  AnimeTitleSummaryRow.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct AnimeTitleSummaryRow: View {
    private enum Constants {
        static let genreLimit = 3
    }

    let title: AnimeTitle

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(title.titleRu)
                .font(Typography.bodySemibold)
                .foregroundStyle(DesignTokens.Colors.text)

            HStack(spacing: Spacing.sm) {
                if let year = title.year {
                    Text(String(year))
                }

                if let rating = title.rating {
                    Text(rating.formatted(.number.precision(.fractionLength(1))))
                }

                if !title.genres.isEmpty {
                    Text(title.genres.prefix(Constants.genreLimit).map(\.name).joined(separator: ", "))
                }
            }
            .font(Typography.caption)
            .foregroundStyle(DesignTokens.Colors.textMuted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.ms)
        .glassSurface(style: .regular, radius: CornerRadius.md)
    }
}
