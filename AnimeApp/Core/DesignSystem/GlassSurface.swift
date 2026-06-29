import SwiftUI

enum GlassSurfaceStyle: Sendable {
    case regular
    case strong
    case accent

    var fill: Color {
        switch self {
        case .regular:
            Color(red: 0.071, green: 0.063, blue: 0.094).opacity(0.58)
        case .strong:
            Color(red: 0.071, green: 0.063, blue: 0.094).opacity(0.78)
        case .accent:
            DesignTokens.Colors.primary.opacity(0.22)
        }
    }

    var materialOpacity: Double {
        switch self {
        case .regular:
            0.24
        case .strong:
            0.16
        case .accent:
            0.20
        }
    }

    var rim: Color {
        switch self {
        case .regular, .strong:
            Color.white.opacity(0.14)
        case .accent:
            DesignTokens.Colors.primaryHover.opacity(0.42)
        }
    }
}

struct GlassSurface<Content: View>: View {
    let style: GlassSurfaceStyle
    let radius: CGFloat
    let content: Content

    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    init(
        style: GlassSurfaceStyle = .regular,
        radius: CGFloat = DesignTokens.Radius.extraLarge,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.radius = radius
        self.content = content()
    }

    var body: some View {
        content
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(style.rim, lineWidth: 1)
            )
            .shadow(color: DesignTokens.Shadow.medium, radius: 18, x: 0, y: 12)
    }

    @ViewBuilder
    private var background: some View {
        let shape = RoundedRectangle(cornerRadius: radius, style: .continuous)

        if reduceTransparency {
            shape.fill(DesignTokens.Colors.elevated)
        } else {
            shape
                .fill(style.fill)
                .overlay {
                    shape
                        .fill(.ultraThinMaterial)
                        .opacity(style.materialOpacity)
                }
                .overlay(alignment: .topLeading) {
                    shape
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.16),
                                    Color.white.opacity(0.04),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .blendMode(.screen)
                }
        }
    }
}

extension View {
    func glassSurface(
        style: GlassSurfaceStyle = .regular,
        radius: CGFloat = DesignTokens.Radius.extraLarge
    ) -> some View {
        GlassSurface(style: style, radius: radius) {
            self
        }
    }
}

#Preview("Glass Surface") {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        VStack(spacing: 16) {
            GlassSurface {
                Text("Regular glass")
                    .foregroundStyle(.white)
                    .padding(20)
            }
            GlassSurface(style: .strong) {
                Text("Strong glass")
                    .foregroundStyle(.white)
                    .padding(20)
            }
            GlassSurface(style: .accent) {
                Text("Accent glass")
                    .foregroundStyle(.white)
                    .padding(20)
            }
        }
        .padding()
    }
}
