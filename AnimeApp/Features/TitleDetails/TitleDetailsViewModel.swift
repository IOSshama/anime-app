//
//  TitleDetailsViewModel.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class TitleDetailsViewModel {
    private(set) var phase: ScreenPhase<AnimeTitleDetails> = .idle

    private var loadedTitleId: String?

    func loadIfNeeded(
        titleId: String,
        using useCase: LoadTitleDetailsUseCase
    ) async {
        guard loadedTitleId != titleId else {
            return
        }

        await reload(titleId: titleId, using: useCase)
    }

    func reload(
        titleId: String,
        using useCase: LoadTitleDetailsUseCase
    ) async {
        phase = .loading

        do {
            let details = try await useCase(id: titleId)
            loadedTitleId = titleId
            phase = .loaded(details)
        } catch {
            phase = .failed(error.localizedDescription)
        }
    }
}
