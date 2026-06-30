//
//  CatalogViewModel.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import Observation

struct CatalogLoadedState: Hashable, Sendable {
    let page: CatalogPage
    let filters: CatalogFiltersMeta
}

@MainActor
@Observable
final class CatalogViewModel {
    private(set) var phase: ScreenPhase<CatalogLoadedState> = .idle
    private(set) var query = CatalogQuery()

    private var didLoad = false

    func loadIfNeeded(
        catalogUseCase: LoadCatalogUseCase,
        filtersUseCase: LoadCatalogFiltersUseCase
    ) async {
        guard !didLoad else {
            return
        }

        await reload(catalogUseCase: catalogUseCase, filtersUseCase: filtersUseCase)
    }

    func reload(
        catalogUseCase: LoadCatalogUseCase,
        filtersUseCase: LoadCatalogFiltersUseCase
    ) async {
        phase = .loading

        do {
            async let page = catalogUseCase(query: query)
            async let filters = filtersUseCase()
            let loadedState = try await CatalogLoadedState(page: page, filters: filters)
            didLoad = true
            phase = .loaded(loadedState)
        } catch {
            phase = .failed(error.localizedDescription)
        }
    }
}
