//
//  FilterChip.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct FilterChip: View {
    private enum Constants {
        static let itemSpacing: CGFloat = 6
        static let horizontalPadding: CGFloat = Spacing.ms
        static let height: CGFloat = 34
        static let selectedOpacity: Double = 0.20
        static let selectedBorderOpacity: Double = 0.48
        static let borderWidth: CGFloat = 1
    }

    let title: String
    var systemImage: String?
    var isSelected: Bool = false
    var role: Role = .regular
    var action: () -> Void

    enum Role: Sendable {
        case regular
        case include
        case exclude

        var accent: Color {
            switch self {
            case .regular:
                DesignTokens.Colors.primaryHover
            case .include:
                DesignTokens.Colors.rating
            case .exclude:
                DesignTokens.Colors.danger
            }
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: Constants.itemSpacing) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(Typography.badgeBold)
                }

                Text(title)
                    .lineLimit(1)
            }
            .font(Typography.captionSemibold)
            .foregroundStyle(isSelected ? DesignTokens.Colors.text : DesignTokens.Colors.textBody)
            .padding(.horizontal, Constants.horizontalPadding)
            .frame(height: Constants.height)
            .background {
                Capsule(style: .continuous)
                    .fill(isSelected ? role.accent.opacity(Constants.selectedOpacity) : DesignTokens.Colors.surface)
                    .overlay {
                        Capsule(style: .continuous)
                            .strokeBorder(
                                isSelected ? role.accent.opacity(Constants.selectedBorderOpacity) : DesignTokens.Colors.lineMedium,
                                lineWidth: Constants.borderWidth
                            )
                    }
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        FlowPreview()
            .padding(Spacing.md)
    }
}

private struct FlowPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.ms) {
            HStack {
                FilterChip(title: StringResource.DesignSystem.sampleOngoing, systemImage: "dot.radiowaves.left.and.right", isSelected: true) {}
                FilterChip(title: StringResource.DesignSystem.sampleComedy) {}
            }
            HStack {
                FilterChip(title: StringResource.DesignSystem.sampleAction, isSelected: true, role: .include) {}
                FilterChip(title: StringResource.DesignSystem.sampleHorror, isSelected: true, role: .exclude) {}
            }
        }
    }
}
