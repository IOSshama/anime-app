//
//  PlaybackView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct PlaybackView: View {
    let titleId: String
    let episodeId: String?

    var body: some View {
        PlaceholderFeatureView(
            title: StringResource.Placeholder.playbackTitle,
            subtitle: StringResource.Placeholder.playbackSubtitle(
                titleId: titleId,
                episodeId: episodeId ?? StringResource.Placeholder.playbackAutoEpisode
            )
        )
    }
}
