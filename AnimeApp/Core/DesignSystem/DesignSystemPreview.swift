import SwiftUI

struct DesignSystemPreview: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeader(title: "Design System", subtitle: "Базовые компоненты AnimeApp")

                GlassSurface {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Liquid glass surface")
                            .font(.headline)
                            .foregroundStyle(DesignTokens.Colors.text)

                        Text("Используется для панелей, меню и floating controls.")
                            .font(.subheadline)
                            .foregroundStyle(DesignTokens.Colors.textMuted)
                    }
                    .padding(18)
                }

                HStack {
                    Button("Смотреть") {}
                        .buttonStyle(AnimeButtonStyle(variant: .primary))

                    IconGlassButton(systemName: "bookmark", accessibilityLabel: "Буду смотреть") {}
                    IconGlassButton(systemName: "star.fill", accessibilityLabel: "Оценить", isActive: true) {}
                }

                HStack {
                    RatingBadge(score: 8.4)
                    StatusPill(kind: .ongoing)
                    StatusPill(kind: .planned)
                }

                HStack {
                    FilterChip(title: "Онгоинг", isSelected: true) {}
                    FilterChip(title: "Экшен", isSelected: true, role: .include) {}
                    FilterChip(title: "Хоррор", isSelected: true, role: .exclude) {}
                }

                PosterPlaceholder(title: "Постер")
                    .frame(width: 150)
            }
            .padding(20)
        }
        .animeScreenBackground()
    }
}

#Preview("Design System") {
    DesignSystemPreview()
}
