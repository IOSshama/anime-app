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
    func search(query: String) async throws -> [AnimeTitle]
    func titleDetails(id: String) async throws -> AnimeTitle
    func franchiseEpisodes(titleId: String) async throws -> [EpisodeGroup]
    func playback(titleId: String, episodeId: String?, selection: PlaybackSelection?) async throws -> PlaybackSession
}

struct HomeSections: Hashable, Sendable {
    var sections: [HomeSection]
}

struct HomeSection: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let titles: [AnimeTitle]
}

struct CatalogQuery: Hashable, Sendable {
    var page: Int = 1
    var search: String?
    var sort: String = "popularity"
}

struct CatalogPage: Hashable, Sendable {
    let items: [AnimeTitle]
    let page: Int
    let totalPages: Int
    let totalItems: Int
}

struct PlaybackSelection: Hashable, Sendable {
    var audioTrackId: String?
    var subtitleTrackId: String?
    var quality: PlaybackQuality = .auto
}
