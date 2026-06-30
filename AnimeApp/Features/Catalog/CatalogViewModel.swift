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
    private(set) var isLoadingNextPage = false

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

    func applySort(
        _ sort: CatalogSort,
        catalogUseCase: LoadCatalogUseCase,
        filtersUseCase: LoadCatalogFiltersUseCase
    ) async {
        guard query.sort != sort else {
            return
        }

        query.sort = sort
        query.page = 1
        await reload(catalogUseCase: catalogUseCase, filtersUseCase: filtersUseCase)
    }

    func toggleGenre(
        _ genre: Genre,
        catalogUseCase: LoadCatalogUseCase,
        filtersUseCase: LoadCatalogFiltersUseCase
    ) async {
        query.genreSlug = query.genreSlug == genre.id ? nil : genre.id
        query.page = 1
        await reload(catalogUseCase: catalogUseCase, filtersUseCase: filtersUseCase)
    }

    func applyQuery(
        _ nextQuery: CatalogQuery,
        catalogUseCase: LoadCatalogUseCase,
        filtersUseCase: LoadCatalogFiltersUseCase
    ) async {
        var normalizedQuery = nextQuery
        normalizedQuery.page = 1

        guard query != normalizedQuery else {
            return
        }

        query = normalizedQuery
        await reload(catalogUseCase: catalogUseCase, filtersUseCase: filtersUseCase)
    }

    func loadNextPage(using catalogUseCase: LoadCatalogUseCase) async {
        guard !isLoadingNextPage, case .loaded(let state) = phase, state.page.page < state.page.totalPages else {
            return
        }

        isLoadingNextPage = true
        defer { isLoadingNextPage = false }

        var nextQuery = query
        nextQuery.page = state.page.page + 1

        do {
            let nextPage = try await catalogUseCase(query: nextQuery)
            query.page = nextPage.page
            phase = .loaded(
                CatalogLoadedState(
                    page: state.page.appending(nextPage),
                    filters: state.filters
                )
            )
        } catch {
            phase = .failed(error.localizedDescription)
        }
    }
}

private extension CatalogPage {
    func appending(_ nextPage: CatalogPage) -> CatalogPage {
        var seenIDs = Set(items.map(\.id))
        let nextItems = nextPage.items.filter { item in
            seenIDs.insert(item.id).inserted
        }

        return CatalogPage(
            items: items + nextItems,
            page: nextPage.page,
            pageSize: nextPage.pageSize,
            totalPages: nextPage.totalPages,
            totalItems: nextPage.totalItems
        )
    }
}
