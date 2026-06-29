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
            Label("Главная", systemImage: "house")
        case .catalog:
            Label("Каталог", systemImage: "square.grid.2x2")
        case .library:
            Label("Моё", systemImage: "bookmark")
        case .profile:
            Label("Профиль", systemImage: "person.crop.circle")
        }
    }
}
