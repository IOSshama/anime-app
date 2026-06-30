//
//  HomeViewModel.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    private(set) var phase: ScreenPhase<HomeSections> = .idle

    private var didLoad = false

    func loadIfNeeded(using useCase: LoadHomeUseCase) async {
        guard !didLoad else {
            return
        }

        await reload(using: useCase)
    }

    func reload(using useCase: LoadHomeUseCase) async {
        phase = .loading

        do {
            let sections = try await useCase()
            didLoad = true
            phase = .loaded(sections)
        } catch {
            phase = .failed(error.localizedDescription)
        }
    }
}
