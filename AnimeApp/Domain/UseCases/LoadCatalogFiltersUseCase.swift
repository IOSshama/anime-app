//
//  LoadCatalogFiltersUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct LoadCatalogFiltersUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction() async throws -> CatalogFiltersMeta {
        try await repository.filtersMeta()
    }
}
