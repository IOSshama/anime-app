import Foundation
import SwiftData

@MainActor
final class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    private init() {
        do {
            container = try ModelContainer(for: LocalPlaybackProgress.self)
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }
}
