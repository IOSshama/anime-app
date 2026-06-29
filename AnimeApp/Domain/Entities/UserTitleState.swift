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
