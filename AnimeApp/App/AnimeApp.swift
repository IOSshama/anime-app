//
//  AnimeApp.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI
import SwiftData

@main
struct AnimeApp: App {
    private let dependencies = DependencyContainer.live

    var body: some Scene {
        WindowGroup {
            AppView()
                .withAppDependencies(dependencies)
                .modelContainer(PersistenceController.shared.container)
        }
    }
}
