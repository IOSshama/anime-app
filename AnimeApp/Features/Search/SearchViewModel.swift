//
//  SearchViewModel.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {
    var query = ""
    private(set) var phase: ScreenPhase<CatalogPage> = .idle

    func search(using useCase: SearchAnimeUseCase) async {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !normalizedQuery.isEmpty else {
            phase = .idle
            return
        }

        phase = .loading

        do {
            let page = try await useCase(query: SearchQuery(query: normalizedQuery))
            phase = .loaded(page)
        } catch {
            phase = .failed(error.localizedDescription)
        }
    }
}
