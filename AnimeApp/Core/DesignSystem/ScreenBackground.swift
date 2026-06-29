//
//  ScreenBackground.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct ScreenBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(DesignTokens.Colors.background.ignoresSafeArea())
            .toolbarBackground(DesignTokens.Colors.background, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

extension View {
    func animeScreenBackground() -> some View {
        modifier(ScreenBackground())
    }
}
