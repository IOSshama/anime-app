//
//  APIAnimeRepository.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct APIAnimeRepository: AnimeRepository {
    let apiClient: APIClient

    func home() async throws -> HomeSections {
        let dto: HomeDTO = try await apiClient.send(AnimeAPI.home())
        return dto.toDomain()
    }

    func catalog(query: CatalogQuery) async throws -> CatalogPage {
        let dto: CatalogPageDTO = try await apiClient.send(AnimeAPI.catalog(query: query))
        return dto.toDomain()
    }

    func catalogCount() async throws -> Int {
        let dto: CatalogCountDTO = try await apiClient.send(AnimeAPI.catalogCount())
        return dto.total
    }

    func filtersMeta() async throws -> CatalogFiltersMeta {
        let dto: FiltersMetaDTO = try await apiClient.send(AnimeAPI.filtersMeta())
        return dto.toDomain()
    }

    func studios() async throws -> [Studio] {
        let dto: [StudioDTO] = try await apiClient.send(AnimeAPI.studios())
        return dto.map { $0.toDomain() }
    }

    func search(query: SearchQuery) async throws -> CatalogPage {
        let dto: SearchResultDTO = try await apiClient.send(AnimeAPI.search(query: query))
        return dto.toDomain()
    }

    func titleDetails(id: String) async throws -> AnimeTitleDetails {
        let dto: TitleDetailsDTO = try await apiClient.send(AnimeAPI.titleDetails(id: id))
        return dto.toDomain()
    }

    func franchiseEpisodes(titleId: String) async throws -> [EpisodeGroup] {
        []
    }

    func playback(titleId: String, episodeId: String?, selection: PlaybackSelection?) async throws -> PlaybackSession {
        throw APIError.invalidResponse
    }
}
