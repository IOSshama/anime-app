//
//  AnimeRepository.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

protocol AnimeRepository: Sendable {
    func home() async throws -> HomeSections
    func catalog(query: CatalogQuery) async throws -> CatalogPage
    func catalogCount() async throws -> Int
    func filtersMeta() async throws -> CatalogFiltersMeta
    func studios() async throws -> [Studio]
    func search(query: SearchQuery) async throws -> CatalogPage
    func titleDetails(id: String) async throws -> AnimeTitleDetails
    func franchiseEpisodes(titleId: String) async throws -> [EpisodeGroup]
    func playback(titleId: String, episodeId: String?, selection: PlaybackSelection?) async throws -> PlaybackSession
}

struct HomeSections: Hashable, Sendable {
    var hero: [AnimeTitle]
    var comingSoon: [UpcomingTitle]
    var sections: [HomeSection]
    var topGenres: [Genre]
    var studios: [Studio]
}

struct HomeSection: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let subtitle: String?
    let titles: [AnimeTitle]
}

struct CatalogQuery: Hashable, Sendable {
    var page: Int = 1
    var pageSize: Int = 24
    var sort: CatalogSort = .popularity
    var type: AnimeType?
    var status: AnimeStatus?
    var genreSlug: String?
    var year: Int?
    var studioId: String?
}

enum CatalogSort: String, Hashable, Sendable {
    case popularity
    case score
    case year
    case name
    case underrated
    case random
}

struct SearchQuery: Hashable, Sendable {
    var query: String
    var page: Int = 1
    var pageSize: Int = 24
}

struct CatalogPage: Hashable, Sendable {
    let items: [AnimeTitle]
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalItems: Int
}

struct PlaybackSelection: Hashable, Sendable {
    var audioTrackId: String?
    var subtitleTrackId: String?
    var quality: PlaybackQuality = .auto
}
