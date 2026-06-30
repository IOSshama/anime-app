//
//  HomeStudioRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeStudioRail: View {
    private enum Constants {
        static let maxItems = 20
        static let tileWidth: CGFloat = 158
        static let tileHeight: CGFloat = 92
        static let logoHeight: CGFloat = 38
        static let borderWidth: CGFloat = 1
    }

    let studios: [Studio]
    var onSelect: (Studio) -> Void

    var body: some View {
        if !studios.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HomeRailHeader(title: StringResource.Home.studios, showAll: false)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: Spacing.ms) {
                        ForEach(studios.prefix(Constants.maxItems)) { studio in
                            Button {
                                onSelect(studio)
                            } label: {
                                studioTile(studio)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, Spacing.ml)
                    .padding(.vertical, Spacing.sm)
                }
            }
        }
    }

    private func studioTile(_ studio: Studio) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .fill(Color.white)

            if studio.logoURL != nil {
                HomeRemoteImage(url: studio.logoURL, contentMode: .fit)
                    .padding(Spacing.md)
                    .frame(height: Constants.logoHeight)
            } else {
                Text(studio.name)
                    .font(Typography.bodySemibold)
                    .foregroundStyle(DesignTokens.Colors.card)
                    .multilineTextAlignment(.center)
                    .padding(Spacing.md)
            }
        }
        .frame(width: Constants.tileWidth, height: Constants.tileHeight)
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
    }
}
