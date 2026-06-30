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
        static let tileWidth: CGFloat = 178
        static let tileHeight: CGFloat = 106
        static let logoMaxHeight: CGFloat = 58
        static let horizontalPadding: CGFloat = Spacing.lg
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

            studioLogo(studio)
        }
        .frame(width: Constants.tileWidth, height: Constants.tileHeight)
        .overlay {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
        }
    }

    @ViewBuilder
    private func studioLogo(_ studio: Studio) -> some View {
        if let logoURL = studio.logoURL {
            AsyncImage(url: logoURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(
                            maxWidth: Constants.tileWidth - Constants.horizontalPadding * 2,
                            maxHeight: Constants.logoMaxHeight
                        )
                case .empty, .failure:
                    studioName(studio.name)
                @unknown default:
                    studioName(studio.name)
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
        } else {
            studioName(studio.name)
        }
    }

    private func studioName(_ name: String) -> some View {
        Text(name)
            .font(Typography.bodySemibold)
            .foregroundStyle(DesignTokens.Colors.card)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding(Spacing.md)
    }
}
