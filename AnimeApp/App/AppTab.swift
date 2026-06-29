//
//  AppTab.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case home
    case catalog
    case library
    case profile

    var id: String { rawValue }

    @ViewBuilder
    var rootView: some View {
        switch self {
        case .home:
            HomeView()
        case .catalog:
            CatalogView()
        case .library:
            LibraryView()
        case .profile:
            ProfileView()
        }
    }

    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label(StringResource.Tab.home, systemImage: "house")
        case .catalog:
            Label(StringResource.Tab.catalog, systemImage: "square.grid.2x2")
        case .library:
            Label(StringResource.Tab.library, systemImage: "bookmark")
        case .profile:
            Label(StringResource.Tab.profile, systemImage: "person.crop.circle")
        }
    }
}
