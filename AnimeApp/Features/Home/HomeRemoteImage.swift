//
//  HomeRemoteImage.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeRemoteImage: View {
    let url: URL?
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                HomeImagePlaceholder()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure:
                HomeImagePlaceholder()
            @unknown default:
                HomeImagePlaceholder()
            }
        }
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
