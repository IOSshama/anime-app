//
//  PersistenceController.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

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
