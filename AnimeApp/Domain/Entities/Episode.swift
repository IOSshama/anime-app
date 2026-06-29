//
//  Episode.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct Episode: Identifiable, Hashable, Sendable {
    let id: String
    let titleId: String
    let number: Int
    let seasonNumber: Int?
    let title: String?
    let thumbnailURL: URL?
    let rating: Double?
    let duration: TimeInterval?
    let releasedAt: Date?
    let hasStream: Bool
    let progress: EpisodeProgress?
}

struct EpisodeProgress: Hashable, Sendable {
    let position: TimeInterval
    let duration: TimeInterval?
    let completed: Bool
}

struct EpisodeGroup: Identifiable, Hashable, Sendable {
    let id: String
    let titleId: String
    let title: String
    let kind: EpisodeGroupKind
    let seasonNumber: Int?
    let episodes: [Episode]
}

enum EpisodeGroupKind: String, Hashable, Sendable {
    case season
    case specials
    case movie
    case ova
    case ona
    case special
}
