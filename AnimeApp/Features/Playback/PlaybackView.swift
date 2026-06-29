import SwiftUI

struct PlaybackView: View {
    let titleId: String
    let episodeId: String?

    var body: some View {
        PlaceholderFeatureView(
            title: "Плеер",
            subtitle: "Title: \(titleId), episode: \(episodeId ?? "auto")"
        )
    }
}
