//
//  HomeGenreRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeGenreRail: View {
    private enum Constants {
        static let maxItems = 12
        static let tileWidth: CGFloat = 128
        static let tileHeight: CGFloat = 72
        static let gradientOpacity: Double = 0.95
    }

    let genres: [Genre]
    var onSelect: (Genre) -> Void

    var body: some View {
        if !genres.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HomeRailHeader(title: StringResource.Home.genres, showAll: false)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: Spacing.ms) {
                        ForEach(Array(genres.prefix(Constants.maxItems).enumerated()), id: \.element.id) { index, genre in
                            Button {
                                onSelect(genre)
                            } label: {
                                Text(genre.name)
                                    .font(Typography.bodySemibold)
                                    .foregroundStyle(DesignTokens.Colors.text)
                                    .lineLimit(2)
                                    .frame(width: Constants.tileWidth, height: Constants.tileHeight)
                                    .background(genreGradient(index: index))
                                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
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

    private func genreGradient(index: Int) -> LinearGradient {
        let colors = HomeGenrePalette.colors[index % HomeGenrePalette.colors.count]
        return LinearGradient(
            colors: colors.map { $0.opacity(Constants.gradientOpacity) },
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private enum HomeGenrePalette {
    static let colors: [[Color]] = [
        [DesignTokens.Colors.primary, DesignTokens.Colors.primaryHover],
        [DesignTokens.Colors.info, Color(red: 0.133, green: 0.827, blue: 0.933)],
        [Color(red: 0.859, green: 0.153, blue: 0.467), Color(red: 0.957, green: 0.447, blue: 0.714)],
        [Color(red: 0.020, green: 0.588, blue: 0.412), Color(red: 0.204, green: 0.827, blue: 0.600)],
        [Color(red: 0.851, green: 0.467, blue: 0.024), DesignTokens.Colors.warning],
        [DesignTokens.Colors.danger, Color(red: 0.984, green: 0.447, blue: 0.522)]
    ]
}
