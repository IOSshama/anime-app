import SwiftUI

struct RatingBadge: View {
    let score: Double

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(color)

            Text(score, format: .number.precision(.fractionLength(1)))
                .font(.system(size: 12, weight: .bold, design: .rounded))
        }
        .foregroundStyle(DesignTokens.Colors.text)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background {
            Capsule(style: .continuous)
                .fill(Color.black.opacity(0.62))
                .overlay {
                    Capsule(style: .continuous)
                        .strokeBorder(DesignTokens.Colors.lineStrong, lineWidth: 1)
                }
        }
        .accessibilityLabel("Рейтинг \(score.formatted(.number.precision(.fractionLength(1))))")
    }

    private var color: Color {
        switch score {
        case 8.0...:
            DesignTokens.Colors.rating
        case 6.5..<8.0:
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
                "Анонс"
            case .ongoing:
                "Онгоинг"
            case .released:
                "Вышло"
            case .planned:
                "Буду"
            case .watching:
                "Смотрю"
            case .completed:
                "Просмотрено"
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
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(kind.color)
            .padding(.horizontal, 9)
            .padding(.vertical, 5)
            .background {
                Capsule(style: .continuous)
                    .fill(kind.color.opacity(0.14))
                    .overlay {
                        Capsule(style: .continuous)
                            .strokeBorder(kind.color.opacity(0.34), lineWidth: 1)
                    }
            }
    }
}

#Preview("Badges") {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        VStack(spacing: 12) {
            RatingBadge(score: 8.7)
            HStack {
                StatusPill(kind: .announced)
                StatusPill(kind: .ongoing)
                StatusPill(kind: .completed)
            }
        }
    }
}
