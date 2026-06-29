//
//  LocalPlaybackProgress.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import SwiftData

@Model
final class LocalPlaybackProgress {
    @Attribute(.unique) var episodeId: String
    var titleId: String
    var positionSeconds: Double
    var durationSeconds: Double?
    var updatedAt: Date

    init(
        episodeId: String,
        titleId: String,
        positionSeconds: Double,
        durationSeconds: Double? = nil,
        updatedAt: Date = .now
    ) {
        self.episodeId = episodeId
        self.titleId = titleId
        self.positionSeconds = positionSeconds
        self.durationSeconds = durationSeconds
        self.updatedAt = updatedAt
    }
}
