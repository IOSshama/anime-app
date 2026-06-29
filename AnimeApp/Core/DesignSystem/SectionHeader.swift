//
//  SectionHeader.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct SectionHeader: View {
    private enum Constants {
        static let textSpacing: CGFloat = Spacing.xs
        static let minimumTrailingSpacing: CGFloat = Spacing.ms
    }

    let title: String
    var subtitle: String?
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: Constants.textSpacing) {
                Text(title)
                    .font(Typography.sectionTitle)
                    .foregroundStyle(DesignTokens.Colors.text)

                if let subtitle {
                    Text(subtitle)
                        .font(Typography.subheadline)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                }
            }

            Spacer(minLength: Constants.minimumTrailingSpacing)

            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(Typography.subheadlineSemibold)
                    .foregroundStyle(DesignTokens.Colors.primaryLink)
            }
        }
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.background.ignoresSafeArea()
        SectionHeader(
            title: StringResource.DesignSystem.previewTitle,
            subtitle: StringResource.DesignSystem.previewSubtitle,
            actionTitle: StringResource.DesignSystem.watch
        ) {}
        .padding(Spacing.md)
    }
}
