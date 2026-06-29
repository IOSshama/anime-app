import Foundation

struct LoadCatalogUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction(query: CatalogQuery) async throws -> CatalogPage {
        try await repository.catalog(query: query)
    }
}
