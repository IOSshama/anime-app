//
//  SearchView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct SearchView: View {
    private enum Constants {
        static let titlePreviewLimit = 12
    }

    @Environment(\.dependencies) private var dependencies
    @State private var viewModel = SearchViewModel()

    var body: some View {
        @Bindable var viewModel = viewModel

        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: Spacing.md) {
                TextField(StringResource.Search.queryPlaceholder, text: $viewModel.query)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.search)
                    .padding(Spacing.ms)
                    .glassSurface(style: .regular, radius: CornerRadius.md)
                    .onSubmit {
                        Task {
                            await viewModel.search(using: dependencies.searchAnimeUseCase)
                        }
                    }

                content
            }
            .padding(Spacing.ml)
        }
        .navigationTitle(StringResource.Placeholder.searchTitle)
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.phase {
        case .idle:
            Text(StringResource.Search.idleTitle)
                .font(Typography.subheadline)
                .foregroundStyle(DesignTokens.Colors.textMuted)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loading:
            ScreenLoadingView()
        case .failed(let message):
            ScreenErrorView(message: message) {
                Task {
                    await viewModel.search(using: dependencies.searchAnimeUseCase)
                }
            }
        case .loaded(let page):
            loadedView(page)
        }
    }

    private func loadedView(_ page: CatalogPage) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text(StringResource.Search.results(page.totalItems))
                    .font(Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.textMuted)

                ForEach(page.items.prefix(Constants.titlePreviewLimit)) { title in
                    AnimeTitleSummaryRow(title: title)
                }
            }
        }
    }
}
