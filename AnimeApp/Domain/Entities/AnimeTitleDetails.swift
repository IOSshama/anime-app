//
//  AnimeTitleDetails.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct AnimeTitleDetails: Identifiable, Hashable, Sendable {
    let id: String
    let title: AnimeTitle
    let nextEpisodeAt: Date?
    let sequelAnnounced: Bool
    let episodeDuration: TimeInterval?
    let ratings: [TitleRating]
    let characters: [AnimeCharacter]
    let screenshots: [URL]
    let trailers: [AnimeTrailer]
    let similar: [AnimeTitle]
    let related: [RelatedTitle]
    let franchiseSeasons: [FranchiseSeason]
}

struct TitleRating: Hashable, Sendable {
    let source: String
    let score: Double?
    let votes: Int?
}

struct AnimeCharacter: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let photoURL: URL?
    let role: String?
    let seiyuuName: String?
}

struct AnimeTrailer: Identifiable, Hashable, Sendable {
    let id: String
    let provider: String
    let externalId: String
    let label: String?
    let thumbnailURL: URL?
}

struct RelatedTitle: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let relation: String?
    let year: Int?
}

struct FranchiseSeason: Identifiable, Hashable, Sendable {
    let id: String
    let season: Int
    let title: String
    let year: Int?
    let isCurrent: Bool
}

struct UpcomingTitle: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let year: Int?
    let type: AnimeType
    let releaseDate: Date?
    let trailerKey: String?
    let thumbnailURL: URL?
}

struct CatalogFiltersMeta: Hashable, Sendable {
    let genres: [Genre]
    let types: [AnimeType]
    let yearRange: YearRange
}

struct YearRange: Hashable, Sendable {
    let min: Int
    let max: Int
}
