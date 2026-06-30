//
//  LoadStudiosUseCase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct LoadStudiosUseCase: Sendable {
    let repository: AnimeRepository

    func callAsFunction() async throws -> [Studio] {
        try await repository.studios()
    }
}
