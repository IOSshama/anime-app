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
