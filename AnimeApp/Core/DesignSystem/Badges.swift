//
//  Badges.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct RatingBadge: View {
    private enum Constants {
        static let iconSize: CGFloat = 11
        static let horizontalPadding: CGFloat = Spacing.sm
        static let verticalPadding: CGFloat = 5
        static let itemSpacing: CGFloat = Spacing.xs
        static let backgroundOpacity: Double = 0.62
        static let borderWidth: CGFloat = 1
        static let highScore: Double = 8
        static let middleScore: Double = 6.5
    }

    let score: Double

    var body: some View {
        HStack(spacing: Constants.itemSpacing) {
            Image(systemName: "star.fill")
                .font(.system(size: Constants.iconSize, weight: .bold))
                .foregroundStyle(color)

            Text(score, format: .number.precision(.fractionLength(1)))
                .font(Typography.badgeBold)
        }
        .foregroundStyle(DesignTokens.Colors.text)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background {
            Capsule(style: .continuous)
                .fill(Color.black.opacity(Constants.backgroundOpacity))
                .overlay {
                    Capsule(style: .continuous)
                        .strokeBorder(DesignTokens.Colors.lineStrong, lineWidth: Constants.borderWidth)
                }
        }
        .accessibilityLabel(StringResource.Accessibility.rating(score.formatted(.number.precision(.fractionLength(1)))))
    }

    private var color: Color {
        switch score {
        case Constants.highScore...:
            DesignTokens.Colors.rating
        case Constants.middleScore..<Constants.highScore:
            DesignTokens.Colors.gold
        default:
            DesignTokens.Colors.warning
        }
    }
}

struct StatusPill: View {
    enum Kind: Sendable {
        case announced
        case ongoing
        case released
        case planned
        case watching
        case completed

        var title: String {
            switch self {
            case .announced:
                StringResource.Status.announced
            case .ongoing:
                StringResource.Status.ongoing
            case .released:
                StringResource.Status.released
            case .planned:
                StringResource.Status.planned
            case .watching:
                StringResource.Status.watching
            case .completed:
                StringResource.Status.completed
            }
        }

        var color: Color {
            switch self {
            case .announced:
                DesignTokens.Colors.warning
            case .ongoing:
                DesignTokens.Colors.info
            case .released:
                DesignTokens.Colors.rating
            case .planned:
                DesignTokens.Colors.primaryLink
            case .watching:
                DesignTokens.Colors.primaryHover
            case .completed:
                DesignTokens.Colors.rating
            }
        }
    }

    let kind: Kind

    var body: some View {
        Text(kind.title)
            .font(Typography.badge)
            .foregroundStyle(kind.color)
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background {
                Capsule(style: .continuous)
                    .fill(kind.color.opacity(0.14))
                    .overlay {
                        Capsule(style: .continuous)
                            .strokeBorder(kind.color.opacity(Constants.borderOpacity), lineWidth: Constants.borderWidth)
                    }
            }
    }

    private enum Constants {
        static let horizontalPadding: CGFloat = 9
        static let verticalPadding: CGFloat = 5
        static let borderOpacity: Double = 0.34
        static let borderWidth: CGFloat = 1
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        VStack(spacing: Spacing.ms) {
            RatingBadge(score: 8.7)
            HStack {
                StatusPill(kind: .announced)
                StatusPill(kind: .ongoing)
                StatusPill(kind: .completed)
            }
        }
    }
}
