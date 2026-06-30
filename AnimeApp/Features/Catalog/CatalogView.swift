//
//  CatalogView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct CatalogView: View {
    private enum Constants {
        static let titlePreviewLimit = 12
    }

    @Environment(\.dependencies) private var dependencies
    @State private var viewModel = CatalogViewModel()

    var body: some View {
        content
            .navigationTitle(StringResource.Placeholder.catalogTitle)
            .task {
                await viewModel.loadIfNeeded(
                    catalogUseCase: dependencies.loadCatalogUseCase,
                    filtersUseCase: dependencies.loadCatalogFiltersUseCase
                )
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.phase {
        case .idle, .loading:
            ScreenLoadingView()
        case .failed(let message):
            ScreenErrorView(message: message) {
                Task {
                    await viewModel.reload(
                        catalogUseCase: dependencies.loadCatalogUseCase,
                        filtersUseCase: dependencies.loadCatalogFiltersUseCase
                    )
                }
            }
        case .loaded(let state):
            loadedView(state)
        }
    }

    private func loadedView(_ state: CatalogLoadedState) -> some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text(StringResource.Placeholder.catalogTitle)
                        .font(Typography.titleLarge)
                        .foregroundStyle(DesignTokens.Colors.text)

                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(StringResource.Catalog.total(state.page.totalItems))
                        Text(StringResource.Catalog.page(state.page.page, totalPages: state.page.totalPages))
                        Text(StringResource.Catalog.filters(state.filters.genres.count))
                    }
                    .font(Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.textMuted)

                    ForEach(state.page.items.prefix(Constants.titlePreviewLimit)) { title in
                        AnimeTitleSummaryRow(title: title)
                    }
                }
                .padding(Spacing.ml)
            }
        }
    }
}
