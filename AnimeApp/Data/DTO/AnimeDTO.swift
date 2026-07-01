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
    let genres: [AnimeGenreDTO]?
    let studios: [StudioDTO]?
    let nextEpisodeAt: Date?
    let sequelAnnounced: Bool?
    let hasCustomPlayer: Bool?
}

struct AnimeGenreDTO: Decodable, Sendable {
    let slug: String?
    let nameRu: String

    var id: String {
        slug ?? nameRu
    }

    init(from decoder: Decoder) throws {
        if let name = try? decoder.singleValueContainer().decode(String.self) {
            slug = nil
            nameRu = name
            return
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu) ?? slug ?? ""
    }

    private enum CodingKeys: String, CodingKey {
        case slug
        case nameRu
    }
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
    let genres: [AnimeGenreDTO]
    let studios: [StudioDTO]
    let ratings: [TitleRatingDTO]
    let characters: [AnimeCharacterDTO]
    let screenshots: [String]
    let trailers: [AnimeTrailerDTO]
    let similar: [AnimeTitleDTO]
    let related: [RelatedTitleDTO]
    let franchiseSeasons: [FranchiseSeasonDTO]
    let hasCustomPlayer: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case shikimoriId
        case nameRu
        case nameJa
        case nameEn
        case descriptionRu
        case type
        case status
        case nextEpisodeAt
        case sequelAnnounced
        case year
        case episodesTotal
        case episodeDuration
        case ageRating
        case score
        case posterUrl
        case backdropUrl
        case genres
        case studios
        case ratings
        case characters
        case screenshots
        case trailers
        case similar
        case related
        case franchiseSeasons
        case hasCustomPlayer
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        shikimoriId = try container.decodeIfPresent(Int.self, forKey: .shikimoriId)
        nameRu = try container.decode(String.self, forKey: .nameRu)
        nameJa = try container.decodeIfPresent(String.self, forKey: .nameJa)
        nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn)
        descriptionRu = try container.decodeIfPresent(String.self, forKey: .descriptionRu)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        nextEpisodeAt = try container.decodeIfPresent(Date.self, forKey: .nextEpisodeAt)
        sequelAnnounced = try container.decodeIfPresent(Bool.self, forKey: .sequelAnnounced)
        year = try container.decodeIfPresent(Int.self, forKey: .year)
        episodesTotal = try container.decodeIfPresent(Int.self, forKey: .episodesTotal)
        episodeDuration = try container.decodeIfPresent(Int.self, forKey: .episodeDuration)
        ageRating = try container.decodeIfPresent(String.self, forKey: .ageRating)
        score = try container.decodeIfPresent(Double.self, forKey: .score)
        posterUrl = try container.decodeIfPresent(String.self, forKey: .posterUrl)
        backdropUrl = try container.decodeIfPresent(String.self, forKey: .backdropUrl)
        genres = try container.decodeIfPresent([AnimeGenreDTO].self, forKey: .genres) ?? []
        studios = try container.decodeIfPresent([StudioDTO].self, forKey: .studios) ?? []
        ratings = try container.decodeIfPresent([TitleRatingDTO].self, forKey: .ratings) ?? []
        characters = try container.decodeIfPresent([AnimeCharacterDTO].self, forKey: .characters) ?? []
        screenshots = try container.decodeIfPresent([String].self, forKey: .screenshots) ?? []
        trailers = try container.decodeIfPresent([AnimeTrailerDTO].self, forKey: .trailers) ?? []
        similar = try container.decodeIfPresent([AnimeTitleDTO].self, forKey: .similar) ?? []
        related = try container.decodeIfPresent([RelatedTitleDTO].self, forKey: .related) ?? []
        franchiseSeasons = try container.decodeIfPresent([FranchiseSeasonDTO].self, forKey: .franchiseSeasons) ?? []
        hasCustomPlayer = try container.decodeIfPresent(Bool.self, forKey: .hasCustomPlayer) ?? false
    }
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
