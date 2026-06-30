//
//  HomeView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeView: View {
    private enum Constants {
        static let sectionPreviewLimit = 5
        static let titlePreviewLimit = 3
    }

    @Environment(\.dependencies) private var dependencies
    @State private var viewModel = HomeViewModel()

    var body: some View {
        content
            .navigationTitle(StringResource.Placeholder.homeTitle)
            .task {
                await viewModel.loadIfNeeded(using: dependencies.loadHomeUseCase)
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
                    await viewModel.reload(using: dependencies.loadHomeUseCase)
                }
            }
        case .loaded(let sections):
            loadedView(sections)
        }
    }

    private func loadedView(_ sections: HomeSections) -> some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text(StringResource.Placeholder.homeTitle)
                        .font(Typography.titleLarge)
                        .foregroundStyle(DesignTokens.Colors.text)

                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(StringResource.Home.count(StringResource.Home.heroCount, sections.hero.count))
                        Text(StringResource.Home.count(StringResource.Home.comingSoonCount, sections.comingSoon.count))
                        Text(StringResource.Home.count(StringResource.Home.sectionCount, sections.sections.count))
                        Text(StringResource.Home.count(StringResource.Home.genresCount, sections.topGenres.count))
                        Text(StringResource.Home.count(StringResource.Home.studiosCount, sections.studios.count))
                    }
                    .font(Typography.caption)
                    .foregroundStyle(DesignTokens.Colors.textMuted)

                    ForEach(sections.sections.prefix(Constants.sectionPreviewLimit)) { section in
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text(section.displayTitle)
                                .font(Typography.headline)
                                .foregroundStyle(DesignTokens.Colors.text)

                            ForEach(section.titles.prefix(Constants.titlePreviewLimit)) { title in
                                AnimeTitleSummaryRow(title: title)
                            }
                        }
                    }
                }
                .padding(Spacing.ml)
            }
        }
    }
}

private extension HomeSection {
    var displayTitle: String {
        switch id {
        case "thisWeek":
            StringResource.Home.thisWeek
        case "recentlyUpdated":
            StringResource.Home.recentlyUpdated
        case "top10":
            StringResource.Home.top10
        default:
            title
        }
    }
}
