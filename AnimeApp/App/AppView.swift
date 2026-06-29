//
//  AppView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct AppView: View {
    @State private var selectedTab: AppTab = .home
    @State private var router = AppRouter()

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(AppTab.allCases) { tab in
                NavigationStack(path: router.pathBinding(for: tab)) {
                    tab.rootView
                        .navigationDestination(for: AppRoute.self, destination: routeView)
                        .sheet(item: router.sheetBinding(for: tab), content: sheetView)
                }
                .tabItem { tab.label }
                .tag(tab)
            }
        }
        .tint(DesignTokens.Colors.primary)
        .environment(router)
    }

    @ViewBuilder
    private func routeView(_ route: AppRoute) -> some View {
        switch route {
        case .titleDetails(let id):
            TitleDetailsView(titleId: id)
        case .player(let titleId, let episodeId):
            PlaybackView(titleId: titleId, episodeId: episodeId)
        case .collection(let slug):
            Text(StringResource.Route.collection(slug))
        case .studio(let id):
            Text(StringResource.Route.studio(id))
        }
    }

    @ViewBuilder
    private func sheetView(_ sheet: AppSheet) -> some View {
        switch sheet {
        case .auth:
            AuthView()
        case .catalogFilter:
            CatalogFilterPlaceholderView()
        }
    }
}
