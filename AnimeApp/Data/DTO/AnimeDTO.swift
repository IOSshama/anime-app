//
//  AnimeDTO.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct AnimeTitleDTO: Decodable, Sendable {
    let id: String
    let shikimoriId: Int?
    let nameRu: String
    let nameJa: String?
    let nameEn: String?
    let posterUrl: String?
    let backdropUrl: String?
    let score: Double?
    let status: String?
    let type: String?
    let year: Int?
    let episodesTotal: Int?
    let episodeDuration: Int?
    let ageRating: String?
    let descriptionRu: String?
    let genres: [String]?
    let studios: [StudioDTO]?
    let nextEpisodeAt: Date?
    let sequelAnnounced: Bool?
    let hasCustomPlayer: Bool?
}

struct CatalogPageDTO: Decodable, Sendable {
    let items: [AnimeTitleDTO]
    let total: Int
    let page: Int
    let pageSize: Int
}

struct CatalogCountDTO: Decodable, Sendable {
    let total: Int
}

struct HomeDTO: Decodable, Sendable {
    let hero: [AnimeTitleDTO]
    let comingSoon: [UpcomingTitleDTO]
    let thisWeek: [AnimeTitleDTO]
    let recentlyUpdated: [AnimeTitleDTO]
    let rails: [HomeRailDTO]
    let top10: [AnimeTitleDTO]
    let genres: [GenreDTO]
    let studios: [StudioDTO]
}

struct HomeRailDTO: Decodable, Sendable {
    let key: String
    let title: String
    let subtitle: String?
    let items: [AnimeTitleDTO]
}

struct UpcomingTitleDTO: Decodable, Sendable {
    let id: String
    let nameRu: String
    let year: Int?
    let type: String?
    let releaseDate: Date?
    let trailerKey: String?
    let thumbnailUrl: String?
}

struct FiltersMetaDTO: Decodable, Sendable {
    let genres: [GenreDTO]
    let types: [String]
    let years: YearRangeDTO
}

struct GenreDTO: Decodable, Sendable {
    let slug: String
    let nameRu: String
}

struct YearRangeDTO: Decodable, Sendable {
    let min: Int
    let max: Int
}

struct StudioDTO: Decodable, Sendable {
    let id: String?
    let name: String
    let logoUrl: String?
    let titleCount: Int?
}

struct TitleDetailsDTO: Decodable, Sendable {
    let id: String
    let shikimoriId: Int?
    let nameRu: String
    let nameJa: String?
    let nameEn: String?
    let descriptionRu: String?
    let type: String?
    let status: String?
    let nextEpisodeAt: Date?
    let sequelAnnounced: Bool?
    let year: Int?
    let episodesTotal: Int?
    let episodeDuration: Int?
    let ageRating: String?
    let score: Double?
    let posterUrl: String?
    let backdropUrl: String?
    let genres: [String]
    let studios: [StudioDTO]
    let ratings: [TitleRatingDTO]
    let characters: [AnimeCharacterDTO]
    let screenshots: [String]
    let trailers: [AnimeTrailerDTO]
    let similar: [AnimeTitleDTO]
    let related: [RelatedTitleDTO]
    let franchiseSeasons: [FranchiseSeasonDTO]
    let hasCustomPlayer: Bool
}

struct TitleRatingDTO: Decodable, Sendable {
    let source: String
    let score: Double?
    let votes: Int?
}

struct AnimeCharacterDTO: Decodable, Sendable {
    let nameRu: String
    let photoUrl: String?
    let role: String?
    let seiyuuName: String?
}

struct AnimeTrailerDTO: Decodable, Sendable {
    let provider: String
    let externalId: String
    let label: String?
    let thumbnailUrl: String?
}

struct RelatedTitleDTO: Decodable, Sendable {
    let id: String?
    let nameRu: String?
    let relation: String?
    let year: Int?
}

struct FranchiseSeasonDTO: Decodable, Sendable {
    let id: String
    let season: Int
    let nameRu: String
    let year: Int?
    let current: Bool
}

struct SearchResultDTO: Decodable, Sendable {
    let query: String
    let items: [AnimeTitleDTO]
    let total: Int
    let page: Int
    let pageSize: Int
}
