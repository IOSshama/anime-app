//
//  TitleDetailsView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsView: View {
    private enum Constants {
        static let contentSpacing: CGFloat = Spacing.xl
        static let bottomPadding: CGFloat = 120
        static let screenshotPrefetchLimit = 8
        static let characterPrefetchLimit = 12
        static let similarPrefetchLimit = 12
        static let backButtonSize: CGFloat = Spacing.xxl
    }

    let titleId: String

    @Environment(\.dependencies) private var dependencies
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = TitleDetailsViewModel()

    var body: some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
            .overlay(alignment: .topLeading) {
                backButton
                    .padding(.leading, Spacing.ml)
                    .padding(.top, Spacing.sm)
            }
            .task(id: titleId) {
                await viewModel.loadIfNeeded(
                    titleId: titleId,
                    using: dependencies.loadTitleDetailsUseCase
                )
                prefetchLoadedImages()
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
                    prefetchLoadedImages()
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
                LazyVStack(alignment: .leading, spacing: Constants.contentSpacing) {
                    TitleDetailsHeroView(details: details)

                    if let description = details.title.description, !description.isEmpty {
                        TitleDetailsSynopsisView(description: description)
                            .padding(.horizontal, Spacing.ml)
                    }

                    TitleDetailsInfoSection(details: details)
                        .padding(.horizontal, Spacing.ml)

                    TitleDetailsMediaRail(details: details)

                    TitleDetailsCharactersRail(characters: details.characters)

                    TitleDetailsRelatedSection(details: details)
                        .padding(.horizontal, Spacing.ml)

                    TitleDetailsSimilarRail(titles: details.similar)
                }
                .padding(.bottom, Constants.bottomPadding)
            }
            .ignoresSafeArea(edges: .top)
        }
    }

    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(Typography.headline)
                .frame(width: Constants.backButtonSize, height: Constants.backButtonSize)
                .glassSurface(style: .strong, radius: CornerRadius.full)
        }
        .buttonStyle(.plain)
        .foregroundStyle(DesignTokens.Colors.text)
        .accessibilityLabel(StringResource.TitleDetails.back)
    }

    private func prefetchLoadedImages() {
        guard case .loaded(let details) = viewModel.phase else {
            return
        }

        dependencies.imagePipeline.preload(
            details.prefetchURLs(
                screenshotLimit: Constants.screenshotPrefetchLimit,
                characterLimit: Constants.characterPrefetchLimit,
                similarLimit: Constants.similarPrefetchLimit
            )
        )
    }
}

private extension AnimeTitleDetails {
    func prefetchURLs(
        screenshotLimit: Int,
        characterLimit: Int,
        similarLimit: Int
    ) -> [URL] {
        let titleURLs = [title.posterURL, title.bannerURL].compactMap(\.self)
        let screenshotURLs = screenshots.prefix(screenshotLimit)
        let trailerURLs = trailers.compactMap(\.coverURL)
        let characterURLs = characters.prefix(characterLimit).compactMap(\.photoURL)
        let similarURLs = similar.prefix(similarLimit).flatMap { [$0.posterURL, $0.bannerURL].compactMap(\.self) }

        return (titleURLs + screenshotURLs + trailerURLs + characterURLs + similarURLs).removingDuplicates()
    }
}

private extension Array where Element == URL {
    func removingDuplicates() -> [URL] {
        var seenURLs = Set<URL>()

        return filter { url in
            seenURLs.insert(url).inserted
        }
    }
}
