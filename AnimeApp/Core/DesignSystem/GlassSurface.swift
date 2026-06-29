//
//  GlassSurface.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

enum GlassSurfaceStyle: Sendable {
    case regular
    case strong
    case accent

    private enum Constants {
        static let regularFillOpacity: Double = 0.58
        static let strongFillOpacity: Double = 0.78
        static let accentFillOpacity: Double = 0.22
        static let regularMaterialOpacity: Double = 0.24
        static let strongMaterialOpacity: Double = 0.16
        static let accentMaterialOpacity: Double = 0.20
        static let regularRimOpacity: Double = 0.14
        static let accentRimOpacity: Double = 0.42
    }

    var fill: Color {
        switch self {
        case .regular:
            Color(red: 0.071, green: 0.063, blue: 0.094).opacity(Constants.regularFillOpacity)
        case .strong:
            Color(red: 0.071, green: 0.063, blue: 0.094).opacity(Constants.strongFillOpacity)
        case .accent:
            DesignTokens.Colors.primary.opacity(Constants.accentFillOpacity)
        }
    }

    var materialOpacity: Double {
        switch self {
        case .regular:
            Constants.regularMaterialOpacity
        case .strong:
            Constants.strongMaterialOpacity
        case .accent:
            Constants.accentMaterialOpacity
        }
    }

    var rim: Color {
        switch self {
        case .regular, .strong:
            Color.white.opacity(Constants.regularRimOpacity)
        case .accent:
            DesignTokens.Colors.primaryHover.opacity(Constants.accentRimOpacity)
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
        radius: CGFloat = CornerRadius.lg,
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
                    .strokeBorder(style.rim, lineWidth: GlassSurfaceConstants.borderWidth)
            )
            .shadow(color: DesignTokens.Shadow.medium, radius: GlassSurfaceConstants.shadowRadius, x: Spacing.zero, y: GlassSurfaceConstants.shadowY)
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
                                    Color.white.opacity(GlassSurfaceConstants.highlightStartOpacity),
                                    Color.white.opacity(GlassSurfaceConstants.highlightMiddleOpacity),
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
        radius: CGFloat = CornerRadius.lg
    ) -> some View {
        GlassSurface(style: style, radius: radius) {
            self
        }
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        VStack(spacing: Spacing.md) {
            GlassSurface {
                Text(StringResource.DesignSystem.regularGlass)
                    .foregroundStyle(.white)
                    .padding(GlassSurfacePreviewConstants.contentPadding)
            }
            GlassSurface(style: .strong) {
                Text(StringResource.DesignSystem.strongGlass)
                    .foregroundStyle(.white)
                    .padding(GlassSurfacePreviewConstants.contentPadding)
            }
            GlassSurface(style: .accent) {
                Text(StringResource.DesignSystem.accentGlass)
                    .foregroundStyle(.white)
                    .padding(GlassSurfacePreviewConstants.contentPadding)
            }
        }
        .padding(Spacing.md)
    }
}

private enum GlassSurfaceConstants {
    static let borderWidth: CGFloat = 1
    static let shadowRadius: CGFloat = 18
    static let shadowY: CGFloat = 12
    static let highlightStartOpacity: Double = 0.16
    static let highlightMiddleOpacity: Double = 0.04
}

private enum GlassSurfacePreviewConstants {
    static let contentPadding: CGFloat = Spacing.ml
}
