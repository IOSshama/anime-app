//
//  HomeHeroSection.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeHeroSection: View {
    private enum Constants {
        static let posterWidthRatio: CGFloat = 0.84
        static let maxPosterWidth: CGFloat = 390
        static let posterAspectRatio: CGFloat = 2 / 3
        static let heroTopPadding: CGFloat = 0
        static let heroLift: CGFloat = -24
        static let backgroundBlur: CGFloat = 34
        static let backgroundScale: CGFloat = 1.16
        static let posterShadowRadius: CGFloat = 36
        static let posterShadowY: CGFloat = 20
        static let overlayHeightRatio: CGFloat = 0.66
        static let titleLineLimit = 2
        static let genreLimit = 3
        static let dotSize: CGFloat = 6
        static let activeDotWidth: CGFloat = 28
        static let dotHeight: CGFloat = 6
        static let buttonHeight: CGFloat = 44
        static let borderWidth: CGFloat = 1
    }

    let titles: [AnimeTitle]
    let onSelect: (AnimeTitle) -> Void

    @State private var selectedIndex = 0

    var body: some View {
        if !titles.isEmpty {
            GeometryReader { proxy in
                let posterWidth = min(proxy.size.width * Constants.posterWidthRatio, Constants.maxPosterWidth)
                let posterHeight = posterWidth / Constants.posterAspectRatio
                let selectedTitle = titles[safe: selectedIndex] ?? titles[0]

                ZStack(alignment: .center) {
                    ambientBackground(for: selectedTitle)

                    VStack(spacing: Spacing.md) {
                        heroCarousel(
                            availableWidth: proxy.size.width,
                            posterWidth: posterWidth,
                            posterHeight: posterHeight
                        )

                        heroDots
                    }
                    .padding(.top, Constants.heroTopPadding)
                    .padding(.bottom, Spacing.lg)
                    .offset(y: Constants.heroLift)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(maxWidth: .infinity)
            .frame(height: HomeHeroSectionConstants.height)
        }
    }

    private func ambientBackground(for title: AnimeTitle) -> some View {
        ZStack {
            HomeRemoteImage(url: title.posterURL)
                .blur(radius: Constants.backgroundBlur)
                .scaleEffect(Constants.backgroundScale)
                .opacity(0.72)

            LinearGradient(
                colors: [
                    DesignTokens.Colors.background,
                    DesignTokens.Colors.background.opacity(0.34),
                    DesignTokens.Colors.background.opacity(0.72),
                    DesignTokens.Colors.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .clipped()
    }

    private func heroCarousel(
        availableWidth: CGFloat,
        posterWidth: CGFloat,
        posterHeight: CGFloat
    ) -> some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(titles.enumerated()), id: \.element.id) { index, title in
                HStack(spacing: Spacing.zero) {
                    Spacer(minLength: Spacing.zero)

                    heroCard(title: title)
                        .frame(width: posterWidth, height: posterHeight)

                    Spacer(minLength: Spacing.zero)
                }
                .frame(width: availableWidth, height: posterHeight)
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: availableWidth)
        .frame(height: posterHeight)
    }

    private func heroCard(title: AnimeTitle) -> some View {
        Button {
            onSelect(title)
        } label: {
            ZStack(alignment: .bottom) {
                HomeRemoteImage(url: title.posterURL)

                LinearGradient(
                    colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(0.58),
                        Color.black.opacity(0.94)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxHeight: .infinity, alignment: .bottom)

                VStack(spacing: Spacing.sm) {
                    Text(title.titleRu)
                        .font(Typography.titleLarge)
                        .foregroundStyle(DesignTokens.Colors.text)
                        .lineLimit(Constants.titleLineLimit)
                        .multilineTextAlignment(.center)
                        .shadow(color: Color.black.opacity(0.6), radius: Spacing.sm)

                    if !title.genres.isEmpty {
                        Text(title.genres.prefix(Constants.genreLimit).map(\.name).joined(separator: " · "))
                            .font(Typography.captionSemibold)
                            .foregroundStyle(DesignTokens.Colors.textBody)
                            .lineLimit(1)
                    }

                    HStack(spacing: Spacing.sm) {
                        Label(StringResource.DesignSystem.watch, systemImage: "play.fill")
                            .frame(maxWidth: .infinity)
                            .frame(height: Constants.buttonHeight)
                            .background(Color.white)
                            .foregroundStyle(DesignTokens.Colors.background)
                            .clipShape(Capsule(style: .continuous))

                        Text(StringResource.Home.details)
                            .frame(maxWidth: .infinity)
                            .frame(height: Constants.buttonHeight)
                            .glassSurface(style: .strong, radius: CornerRadius.full)
                            .foregroundStyle(DesignTokens.Colors.text)
                    }
                    .font(Typography.button)
                }
                .padding(Spacing.md)
            }
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.xl, style: .continuous))
            .overlay(alignment: .topLeading) {
                if let rating = title.rating {
                    RatingBadge(score: rating)
                        .padding(Spacing.ms)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: CornerRadius.xl, style: .continuous)
                    .strokeBorder(DesignTokens.Colors.lineStrong, lineWidth: Constants.borderWidth)
            }
            .shadow(color: DesignTokens.Shadow.large, radius: Constants.posterShadowRadius, x: Spacing.zero, y: Constants.posterShadowY)
        }
        .buttonStyle(.plain)
    }

    private var heroDots: some View {
        HStack(spacing: Spacing.sm) {
            ForEach(titles.indices, id: \.self) { index in
                Capsule(style: .continuous)
                    .fill(index == selectedIndex ? DesignTokens.Colors.primary : Color.white.opacity(0.42))
                    .frame(
                        width: index == selectedIndex ? Constants.activeDotWidth : Constants.dotSize,
                        height: Constants.dotHeight
                    )
                    .animation(DesignTokens.Motion.ease, value: selectedIndex)
            }
        }
    }
}

private enum HomeHeroSectionConstants {
    static let height: CGFloat = 610
}

private extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
