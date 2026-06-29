import Foundation

struct APIAnimeRepository: AnimeRepository {
    let apiClient: APIClient

    func home() async throws -> HomeSections {
        HomeSections(sections: [])
    }

    func catalog(query: CatalogQuery) async throws -> CatalogPage {
        let dto: CatalogPageDTO = try await apiClient.send(AnimeAPI.catalog(query: query))
        return CatalogPage(
            items: dto.items.map { $0.toDomain() },
            page: dto.page,
            totalPages: dto.totalPages,
            totalItems: dto.totalItems
        )
    }

    func search(query: String) async throws -> [AnimeTitle] {
        let dto: [AnimeTitleDTO] = try await apiClient.send(AnimeAPI.search(query: query))
        return dto.map { $0.toDomain() }
    }

    func titleDetails(id: String) async throws -> AnimeTitle {
        let dto: AnimeTitleDTO = try await apiClient.send(AnimeAPI.titleDetails(id: id))
        return dto.toDomain()
    }

    func franchiseEpisodes(titleId: String) async throws -> [EpisodeGroup] {
        []
    }

    func playback(titleId: String, episodeId: String?, selection: PlaybackSelection?) async throws -> PlaybackSession {
        throw APIError.invalidResponse
    }
}
