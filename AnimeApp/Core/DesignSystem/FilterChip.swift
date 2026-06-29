import SwiftUI

struct FilterChip: View {
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
            HStack(spacing: 6) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 12, weight: .bold))
                }

                Text(title)
                    .lineLimit(1)
            }
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(isSelected ? DesignTokens.Colors.text : DesignTokens.Colors.textBody)
            .padding(.horizontal, 12)
            .frame(height: 34)
            .background {
                Capsule(style: .continuous)
                    .fill(isSelected ? role.accent.opacity(0.20) : DesignTokens.Colors.surface)
                    .overlay {
                        Capsule(style: .continuous)
                            .strokeBorder(isSelected ? role.accent.opacity(0.48) : DesignTokens.Colors.lineMedium, lineWidth: 1)
                    }
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview("Filter Chips") {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        FlowPreview()
            .padding()
    }
}

private struct FlowPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                FilterChip(title: "Онгоинг", systemImage: "dot.radiowaves.left.and.right", isSelected: true) {}
                FilterChip(title: "Комедия") {}
            }
            HStack {
                FilterChip(title: "Экшен", isSelected: true, role: .include) {}
                FilterChip(title: "Хоррор", isSelected: true, role: .exclude) {}
            }
        }
    }
}
