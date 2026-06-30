//
//  ScreenErrorView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct ScreenErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: Spacing.ms) {
                Text(StringResource.State.errorTitle)
                    .font(Typography.title)
                    .foregroundStyle(DesignTokens.Colors.text)

                Text(message)
                    .font(Typography.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(DesignTokens.Colors.textMuted)

                Button(StringResource.State.retry, action: retry)
                    .buttonStyle(AnimeButtonStyle(variant: .primary))
            }
            .padding(.horizontal, Spacing.ml)
        }
    }
}
