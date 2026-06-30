//
//  LoadTitleDetailsUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct LoadTitleDetailsUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction(id: String) async throws -> AnimeTitleDetails {
        try await repository.titleDetails(id: id)
    }
}
