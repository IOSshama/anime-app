//
//  LoadCatalogCountUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct LoadCatalogCountUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction() async throws -> Int {
        try await repository.catalogCount()
    }
}
