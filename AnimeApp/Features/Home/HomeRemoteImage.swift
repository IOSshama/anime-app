//
//  HomeRemoteImage.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI
import NukeUI

struct HomeRemoteImage: View {
    let url: URL?
    var contentMode: ContentMode = .fill

    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                HomeImagePlaceholder()
            }
        }
        .priority(.high)
        .onDisappear(.lowerPriority)
    }
}

private struct HomeImagePlaceholder: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    DesignTokens.Colors.elevated,
                    DesignTokens.Colors.card
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: "photo")
                .font(.system(size: HomeImagePlaceholderConstants.iconSize, weight: .medium))
                .foregroundStyle(DesignTokens.Colors.textFaint)
        }
    }
}

private enum HomeImagePlaceholderConstants {
    static let iconSize: CGFloat = 28
}
