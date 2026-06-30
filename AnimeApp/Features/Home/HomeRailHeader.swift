//
//  HomeRailHeader.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeRailHeader: View {
    let title: String
    var showAll = true
    var action: (() -> Void)?

    var body: some View {
        HStack(alignment: .center) {
            Button {
                action?()
            } label: {
                HStack(spacing: Spacing.xs) {
                    Text(title)
                        .font(Typography.title)
                        .foregroundStyle(DesignTokens.Colors.text)

                    Image(systemName: "chevron.right")
                        .font(Typography.captionSemibold)
                        .foregroundStyle(DesignTokens.Colors.textMuted)
                }
            }
            .buttonStyle(.plain)

            Spacer(minLength: Spacing.sm)

            if showAll {
                Button {
                    action?()
                } label: {
                    HStack(spacing: Spacing.xs) {
                        Text(StringResource.Home.all)
                        Image(systemName: "chevron.right")
                    }
                    .font(Typography.captionSemibold)
                    .foregroundStyle(DesignTokens.Colors.textBody)
                    .padding(.horizontal, Spacing.ms)
                    .padding(.vertical, Spacing.sm)
                    .glassSurface(style: .regular, radius: CornerRadius.full)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, Spacing.ml)
    }
}
