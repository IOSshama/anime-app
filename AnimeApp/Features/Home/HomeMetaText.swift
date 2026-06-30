//
//  HomeMetaText.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum HomeMetaText {
    static func titleMeta(for title: AnimeTitle) -> String {
        [
            typeLabel(for: title.type),
            episodeText(for: title),
            title.year.map(String.init)
        ]
        .compactMap { $0 }
        .joined(separator: " · ")
    }

    static func cardMeta(for title: AnimeTitle) -> String {
        [
            title.year.map(String.init),
            title.rating.map { $0.formatted(.number.precision(.fractionLength(1))) }
        ]
        .compactMap { $0 }
        .joined(separator: "  ")
    }

    private static func episodeText(for title: AnimeTitle) -> String? {
        guard title.type != .movie, let episodeCount = title.episodeCount, episodeCount > 0 else {
            return nil
        }

        return StringResource.Meta.episodes(episodeCount)
    }

    private static func typeLabel(for type: AnimeType) -> String? {
        switch type {
        case .tv:
            StringResource.Meta.tv
        case .movie:
            StringResource.Meta.movie
        case .ova:
            StringResource.Meta.ova
        case .ona:
            StringResource.Meta.ona
        case .special:
            StringResource.Meta.special
        case .music:
            StringResource.Meta.music
        case .unknown:
            nil
        }
    }
}
