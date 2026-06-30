//
//  CatalogView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct CatalogView: View {
    private enum Constants {
        static let genrePreviewLimit = 10
        static let gridSpacing: CGFloat = Spacing.md
        static let filterBarSpacing: CGFloat = Spacing.ms
        static let topPadding: CGFloat = Spacing.lg
        static let bottomPadding: CGFloat = 120
    }

    @Environment(\.dependencies) private var dependencies
    @Environment(AppRouter.self) private var router
    @State private var viewModel = CatalogViewModel()
    @State private var filterSheet: CatalogFilterSheetPayload?

    var body: some View {
        content
            .navigationTitle(StringResource.Placeholder.catalogTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
            .task {
                await viewModel.loadIfNeeded(
                    catalogUseCase: dependencies.loadCatalogUseCase,
                    filtersUseCase: dependencies.loadCatalogFiltersUseCase
                )
                prefetchLoadedImages()
            }
            .sheet(item: $filterSheet) { payload in
                CatalogFilterSheet(
                    filters: payload.filters,
                    currentQuery: payload.query
                ) { query in
                    Task {
                        await viewModel.applyQuery(
                            query,
                            catalogUseCase: dependencies.loadCatalogUseCase,
                            filtersUseCase: dependencies.loadCatalogFiltersUseCase
                        )
                        prefetchLoadedImages()
                    }
                }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
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
                    prefetchLoadedImages()
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
                LazyVStack(alignment: .leading, spacing: Spacing.lg) {
                    header(state)
                    filterBars(state.filters.genres)

                    LazyVGrid(columns: gridColumns, alignment: .center, spacing: Spacing.lg) {
                        ForEach(state.page.items) { title in
                            CatalogPosterCard(title: title) {
                                router.push(.titleDetails(id: title.id), on: .catalog)
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.ml)

                    if state.page.page < state.page.totalPages {
                        loadMoreButton
                    }
                }
                .padding(.top, Constants.topPadding)
                .padding(.bottom, Constants.bottomPadding)
            }
        }
    }

    private var gridColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: Constants.gridSpacing),
            GridItem(.flexible(), spacing: Constants.gridSpacing)
        ]
    }

    private func filterBars(_ genres: [Genre]) -> some View {
        VStack(alignment: .leading, spacing: Constants.filterBarSpacing) {
            sortBar
            genreBar(genres)
        }
    }

    private func header(_ state: CatalogLoadedState) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(alignment: .center, spacing: Spacing.md) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(StringResource.Placeholder.catalogTitle)
                        .font(Typography.display)
                        .foregroundStyle(DesignTokens.Colors.text)

                    Text(StringResource.Catalog.summary(state.page.totalItems))
                        .font(Typography.subheadline)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                }

                Spacer(minLength: Spacing.sm)

                Button {
                    presentFilters(state)
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(Typography.headline)
                        .frame(width: Spacing.xxl, height: Spacing.xxl)
                        .glassSurface(style: .regular, radius: CornerRadius.full)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(StringResource.Catalog.filtersTitle)
            }

            Text(StringResource.Catalog.page(state.page.page, totalPages: state.page.totalPages))
                .font(Typography.caption)
                .foregroundStyle(DesignTokens.Colors.textFaint)
        }
        .padding(.horizontal, Spacing.ml)
    }

    private func presentFilters(_ state: CatalogLoadedState) {
        filterSheet = CatalogFilterSheetPayload(
            query: viewModel.query,
            filters: state.filters
        )
    }

    private var sortBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                ForEach(CatalogSortOption.allCases) { option in
                    FilterChip(
                        title: option.title,
                        systemImage: option.systemImage,
                        isSelected: viewModel.query.sort == option.sort
                    ) {
                        Task {
                            await viewModel.applySort(
                                option.sort,
                                catalogUseCase: dependencies.loadCatalogUseCase,
                                filtersUseCase: dependencies.loadCatalogFiltersUseCase
                            )
                            prefetchLoadedImages()
                        }
                    }
                }
            }
            .padding(.horizontal, Spacing.ml)
        }
    }

    private func genreBar(_ genres: [Genre]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                ForEach(genres.prefix(Constants.genrePreviewLimit)) { genre in
                    FilterChip(
                        title: genre.name,
                        isSelected: viewModel.query.genreSlug == genre.id
                    ) {
                        Task {
                            await viewModel.toggleGenre(
                                genre,
                                catalogUseCase: dependencies.loadCatalogUseCase,
                                filtersUseCase: dependencies.loadCatalogFiltersUseCase
                            )
                            prefetchLoadedImages()
                        }
                    }
                }
            }
            .padding(.horizontal, Spacing.ml)
        }
    }

    private var loadMoreButton: some View {
        Button {
            Task {
                await viewModel.loadNextPage(using: dependencies.loadCatalogUseCase)
                prefetchLoadedImages()
            }
        } label: {
            HStack(spacing: Spacing.sm) {
                if viewModel.isLoadingNextPage {
                    ProgressView()
                        .tint(DesignTokens.Colors.text)
                } else {
                    Image(systemName: "arrow.down")
                }

                Text(StringResource.Catalog.showMore)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(AnimeButtonStyle(variant: .glass, height: Spacing.xxl, radius: CornerRadius.full))
        .disabled(viewModel.isLoadingNextPage)
        .padding(.horizontal, Spacing.ml)
        .padding(.top, Spacing.sm)
    }

    private func prefetchLoadedImages() {
        guard case .loaded(let state) = viewModel.phase else {
            return
        }

        dependencies.imagePipeline.preload(state.page.items.flatMap(\.catalogPrefetchURLs))
    }
}

private extension AnimeTitle {
    var catalogPrefetchURLs: [URL] {
        [posterURL, bannerURL].compactMap(\.self)
    }
}

private struct CatalogFilterSheetPayload: Identifiable {
    let id = UUID()
    let query: CatalogQuery
    let filters: CatalogFiltersMeta
}
