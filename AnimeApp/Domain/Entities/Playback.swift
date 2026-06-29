//
//  Playback.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum PlaybackKind: String, Hashable, Sendable {
    case embed
    case hls
}

enum PlaybackProvider: String, Hashable, Sendable {
    case kodik
    case anilibria
}

enum PlaybackSourceType: String, Hashable, Sendable {
    case hls
    case mp4
}

enum PlaybackQuality: String, Hashable, Sendable {
    case auto
    case p1080 = "1080p"
    case p720 = "720p"
    case p480 = "480p"
    case p360 = "360p"
    case p240 = "240p"
}

enum AudioKind: String, Hashable, Sendable {
    case dub
    case multivoice
    case twovoice
    case voice
    case original
}

struct AudioTrack: Identifiable, Hashable, Sendable {
    let id: String
    let studioName: String
    let kind: AudioKind
    let language: String
    let isPremium: Bool
    let isAvailable: Bool
    let provider: PlaybackProvider
}

struct SubtitleTrack: Identifiable, Hashable, Sendable {
    let id: String
    let label: String
    let language: String
    let isForced: Bool
    let isAvailable: Bool
}

struct PlaybackSource: Hashable, Sendable {
    let quality: PlaybackQuality
    let url: URL
    let type: PlaybackSourceType
}

struct SkipMarkers: Hashable, Sendable {
    let introStart: TimeInterval?
    let introEnd: TimeInterval?
    let outroStart: TimeInterval?
}

struct PlaybackSession: Hashable, Sendable {
    let kind: PlaybackKind
    let episode: Episode
    let embedURL: URL?
    let hlsSources: [PlaybackSource]
    let audioTracks: [AudioTrack]
    let subtitleTracks: [SubtitleTrack]
    let selectedAudioTrackId: String?
    let selectedSubtitleTrackId: String?
    let selectedQuality: PlaybackQuality
    let skip: SkipMarkers?
    let nextEpisodeId: String?
    let resumePosition: TimeInterval?
    let autoplayNext: Bool
    let autoSkipOpening: Bool
}
