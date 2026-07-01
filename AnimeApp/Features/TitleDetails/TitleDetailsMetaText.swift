//
//  TitleDetailsMetaText.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum TitleDetailsMetaText {
    static func primaryMeta(for details: AnimeTitleDetails) -> String {
        [
            typeLabel(for: details.title.type),
            details.title.year.map(String.init),
            details.title.episodeCount.map(StringResource.Meta.episodes),
            durationText(details.episodeDuration),
            details.title.ageRating
        ]
        .compactMap { $0 }
        .joined(separator: " · ")
    }

    static func studiosText(for title: AnimeTitle) -> String? {
        title.studio?.name
    }

    private static func durationText(_ duration: TimeInterval?) -> String? {
        guard let duration, duration > 0 else {
            return nil
        }

        return StringResource.TitleDetails.minutes(Int(duration / 60))
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
