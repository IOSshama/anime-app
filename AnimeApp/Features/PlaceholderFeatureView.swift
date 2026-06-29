import SwiftUI

struct PlaceholderFeatureView: View {
    let title: String
    let subtitle: String

    var body: some View {
        ZStack {
            DesignTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: DesignTokens.Spacing.medium) {
                Text(title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(DesignTokens.Colors.textMuted)
                    .padding(.horizontal, DesignTokens.Spacing.xlarge)
            }
        }
        .navigationTitle(title)
    }
}
