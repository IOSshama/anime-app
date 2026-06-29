//
//  UserTitleState.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct UserTitleState: Hashable, Sendable {
    let titleId: String
    var listStatus: LibraryStatus?
    var isFollowing: Bool
    var lastEpisodeId: String?
    var progressSeconds: TimeInterval
}

enum LibraryStatus: String, Hashable, Sendable {
    case planned
    case watching
    case completed
    case dropped
    case favorite
    case notInterested
}
