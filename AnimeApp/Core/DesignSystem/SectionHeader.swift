import SwiftUI

struct SectionHeader: View {
    let title: String
    var subtitle: String?
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3.bold())
                    .foregroundStyle(DesignTokens.Colors.text)

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                }
            }

            Spacer(minLength: 12)

            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(DesignTokens.Colors.primaryLink)
            }
        }
    }
}

#Preview("Section Header") {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        SectionHeader(title: "Новые серии", subtitle: "Сегодня", actionTitle: "Все") {}
            .padding()
    }
}
