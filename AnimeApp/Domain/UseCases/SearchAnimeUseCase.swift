//
//  SearchAnimeUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct SearchAnimeUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction(query: SearchQuery) async throws -> CatalogPage {
        try await repository.search(query: query)
    }
}
