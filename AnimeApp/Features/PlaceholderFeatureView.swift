//
//  PlaceholderFeatureView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct PlaceholderFeatureView: View {
    let title: String
    let subtitle: String

    var body: some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: Spacing.ms) {
                Text(title)
                    .font(Typography.display)
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(Typography.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
                    .padding(.horizontal, Spacing.lg)
            }
        }
        .navigationTitle(title)
    }
}
