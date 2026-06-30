//
//  LoadHomeUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct LoadHomeUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction() async throws -> HomeSections {
        try await repository.home()
    }
}
