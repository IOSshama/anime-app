//
//  ScreenLoadingView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct ScreenLoadingView: View {
    var body: some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            ProgressView {
                Text(StringResource.State.loading)
                    .font(Typography.subheadline)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
            }
            .tint(DesignTokens.Colors.primary)
        }
    }
}
