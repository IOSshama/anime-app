//
//  TitleDetailsView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsView: View {
    let titleId: String

    @Environment(\.dependencies) private var dependencies
    @State private var viewModel = TitleDetailsViewModel()

    var body: some View {
        content
            .navigationTitle(StringResource.Placeholder.titleDetailsTitle)
            .task(id: titleId) {
                await viewModel.loadIfNeeded(
                    titleId: titleId,
                    using: dependencies.loadTitleDetailsUseCase
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
                        titleId: titleId,
                        using: dependencies.loadTitleDetailsUseCase
                    )
                }
            }
        case .loaded(let details):
            loadedView(details)
        }
    }

    private func loadedView(_ details: AnimeTitleDetails) -> some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text(details.title.titleRu)
                        .font(Typography.titleLarge)
                        .foregroundStyle(DesignTokens.Colors.text)

                    if let description = details.title.description {
                        Text(description)
                            .font(Typography.body)
                            .foregroundStyle(DesignTokens.Colors.textBody)
                    }

                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(StringResource.TitleDetails.screenshots(details.screenshots.count))
                        Text(StringResource.TitleDetails.trailers(details.trailers.count))
                        Text(StringResource.TitleDetails.characters(details.characters.count))
                        Text(StringResource.TitleDetails.similar(details.similar.count))
                    }
                    .font(Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
                }
                .padding(Spacing.ml)
            }
        }
    }
}
