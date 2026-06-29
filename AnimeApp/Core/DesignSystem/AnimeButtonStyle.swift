//
//  AnimeButtonStyle.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

enum AnimeButtonVariant: Sendable {
    case primary
    case secondary
    case glass
    case ghost

    var foreground: Color {
        switch self {
        case .primary, .secondary, .glass:
            DesignTokens.Colors.text
        case .ghost:
            DesignTokens.Colors.textStrong
        }
    }

    var background: Color {
        switch self {
        case .primary:
            DesignTokens.Colors.primary
        case .secondary:
            DesignTokens.Colors.surface04
        case .glass:
            Color.white.opacity(0.08)
        case .ghost:
            Color.clear
        }
    }
}

struct AnimeButtonStyle: ButtonStyle {
    private enum Constants {
        static let defaultHeight: CGFloat = 48
        static let borderWidth: CGFloat = 1
        static let glassBackgroundOpacity: Double = 0.08
        static let pressedScale: CGFloat = 0.98
        static let pressedOpacity: Double = 0.82
    }

    let variant: AnimeButtonVariant
    var height: CGFloat = Constants.defaultHeight
    var radius: CGFloat = CornerRadius.sm

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Typography.button)
            .foregroundStyle(variant.foreground)
            .frame(minHeight: height)
            .padding(.horizontal, Spacing.md)
            .background {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(variant.background)
                    .overlay {
                        if variant == .glass {
                            RoundedRectangle(cornerRadius: radius, style: .continuous)
                                .strokeBorder(DesignTokens.Colors.lineStrong, lineWidth: Constants.borderWidth)
                        }
                    }
            }
            .scaleEffect(configuration.isPressed ? Constants.pressedScale : 1)
            .opacity(configuration.isPressed ? Constants.pressedOpacity : 1)
            .animation(DesignTokens.Motion.ease, value: configuration.isPressed)
    }
}

struct IconGlassButton: View {
    private enum Constants {
        static let defaultSize: CGFloat = 44
        static let iconSize: CGFloat = 17
        static let backgroundOpacity: Double = 0.08
        static let activeBorderOpacity: Double = 0.42
        static let borderWidth: CGFloat = 1
        static let shadowRadius: CGFloat = 12
        static let shadowY: CGFloat = 6
    }

    let systemName: String
    let accessibilityLabel: String
    var size: CGFloat = Constants.defaultSize
    var isActive: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: Constants.iconSize, weight: .semibold))
                .frame(width: size, height: size)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(isActive ? DesignTokens.Colors.primaryLink : DesignTokens.Colors.text)
        .background {
            Circle()
                .fill(isActive ? DesignTokens.Colors.primaryTint : Color.white.opacity(Constants.backgroundOpacity))
                .overlay {
                    Circle()
                        .strokeBorder(
                            isActive ? DesignTokens.Colors.primaryHover.opacity(Constants.activeBorderOpacity) : DesignTokens.Colors.lineStrong,
                            lineWidth: Constants.borderWidth
                        )
                }
                .shadow(color: DesignTokens.Shadow.small, radius: Constants.shadowRadius, x: Spacing.zero, y: Constants.shadowY)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        VStack(spacing: Spacing.md) {
            Button(StringResource.DesignSystem.watch) {}
                .buttonStyle(AnimeButtonStyle(variant: .primary))

            Button(StringResource.DesignSystem.watchLater) {}
                .buttonStyle(AnimeButtonStyle(variant: .secondary))

            HStack {
                IconGlassButton(systemName: "bookmark", accessibilityLabel: StringResource.DesignSystem.watchLater) {}
                IconGlassButton(systemName: "star.fill", accessibilityLabel: StringResource.DesignSystem.rate, isActive: true) {}
            }
        }
        .padding()
    }
}
