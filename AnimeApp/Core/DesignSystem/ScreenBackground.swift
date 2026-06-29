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
