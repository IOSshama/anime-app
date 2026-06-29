//
//  AnimeTitle.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct AnimeTitle: Identifiable, Hashable, Sendable {
    let id: String
    let titleRu: String
    let titleOriginal: String?
    let posterURL: URL?
    let bannerURL: URL?
    let rating: Double?
    let status: AnimeStatus
    let type: AnimeType
    let year: Int?
    let episodeCount: Int?
    let ageRating: String?
    let genres: [Genre]
    let studio: Studio?
    let description: String?
}

enum AnimeStatus: String, Hashable, Sendable {
    case announced
    case ongoing
    case released
    case unknown
}

enum AnimeType: String, Hashable, Sendable {
    case tv
    case movie
    case ova
    case ona
    case special
    case music
    case unknown
}

struct Genre: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
}

struct Studio: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let logoURL: URL?
}
