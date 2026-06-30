//
//  HomeView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeView: View {
    private enum Constants {
        static let sectionLimit = 8
        static let topPadding: CGFloat = 0
        static let bottomPadding: CGFloat = 110
    }

    @Environment(\.dependencies) private var dependencies
    @Environment(AppRouter.self) private var router
    @State private var viewModel = HomeViewModel()

    var body: some View {
        content
            .navigationTitle(StringResource.Placeholder.homeTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
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
                LazyVStack(alignment: .leading, spacing: Spacing.xl) {
                    HomeHeroSection(titles: sections.hero, onSelect: openTitle)

                    HomeComingSoonRail(items: sections.comingSoon)

                    ForEach(sections.sections.prefix(Constants.sectionLimit)) { section in
                        HomeContentRail(
                            title: section.displayTitle,
                            items: section.titles,
                            onSelect: openTitle,
                            onShowAll: {
                                router.push(.collection(slug: section.id), on: .home)
                            }
                        )
                    }

                    HomeGenreRail(genres: sections.topGenres) { genre in
                        router.push(.collection(slug: genre.id), on: .home)
                    }

                    HomeStudioRail(studios: sections.studios) { studio in
                        router.push(.studio(id: studio.id), on: .home)
                    }
                }
                .padding(.top, Constants.topPadding)
                .padding(.bottom, Constants.bottomPadding)
            }
        }
    }

    private func openTitle(_ title: AnimeTitle) {
        router.push(.titleDetails(id: title.id), on: .home)
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
