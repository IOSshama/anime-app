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
    let variant: AnimeButtonVariant
    var height: CGFloat = 48
    var radius: CGFloat = DesignTokens.Radius.medium

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(variant.foreground)
            .frame(minHeight: height)
            .padding(.horizontal, DesignTokens.Spacing.large)
            .background {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(variant.background)
                    .overlay {
                        if variant == .glass {
                            RoundedRectangle(cornerRadius: radius, style: .continuous)
                                .strokeBorder(DesignTokens.Colors.lineStrong, lineWidth: 1)
                        }
                    }
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.82 : 1)
            .animation(DesignTokens.Motion.ease, value: configuration.isPressed)
    }
}

struct IconGlassButton: View {
    let systemName: String
    let accessibilityLabel: String
    var size: CGFloat = 44
    var isActive: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 17, weight: .semibold))
                .frame(width: size, height: size)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(isActive ? DesignTokens.Colors.primaryLink : DesignTokens.Colors.text)
        .background {
            Circle()
                .fill(isActive ? DesignTokens.Colors.primaryTint : Color.white.opacity(0.08))
                .overlay {
                    Circle()
                        .strokeBorder(
                            isActive ? DesignTokens.Colors.primaryHover.opacity(0.42) : DesignTokens.Colors.lineStrong,
                            lineWidth: 1
                        )
                }
                .shadow(color: DesignTokens.Shadow.small, radius: 12, x: 0, y: 6)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

#Preview("Buttons") {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        VStack(spacing: 16) {
            Button("Смотреть") {}
                .buttonStyle(AnimeButtonStyle(variant: .primary))

            Button("Буду смотреть") {}
                .buttonStyle(AnimeButtonStyle(variant: .secondary))

            HStack {
                IconGlassButton(systemName: "bookmark", accessibilityLabel: "Буду смотреть") {}
                IconGlassButton(systemName: "star.fill", accessibilityLabel: "Оценить", isActive: true) {}
            }
        }
        .padding()
    }
}
