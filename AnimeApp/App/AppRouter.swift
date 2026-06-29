//
//  AppRouter.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

@MainActor
@Observable
final class AppRouter {
    private var paths: [AppTab: [AppRoute]] = Dictionary(
        uniqueKeysWithValues: AppTab.allCases.map { ($0, []) }
    )
    private var sheets: [AppTab: AppSheet?] = Dictionary(
        uniqueKeysWithValues: AppTab.allCases.map { ($0, nil) }
    )

    func pathBinding(for tab: AppTab) -> Binding<[AppRoute]> {
        Binding(
            get: { self.paths[tab, default: []] },
            set: { self.paths[tab] = $0 }
        )
    }

    func sheetBinding(for tab: AppTab) -> Binding<AppSheet?> {
        Binding(
            get: { self.sheets[tab] ?? nil },
            set: { self.sheets[tab] = $0 }
        )
    }

    func push(_ route: AppRoute, on tab: AppTab) {
        paths[tab, default: []].append(route)
    }

    func present(_ sheet: AppSheet, on tab: AppTab) {
        sheets[tab] = sheet
    }
}
