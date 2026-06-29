//
//  LoadCatalogUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct LoadCatalogUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction(query: CatalogQuery) async throws -> CatalogPage {
        try await repository.catalog(query: query)
    }
}
