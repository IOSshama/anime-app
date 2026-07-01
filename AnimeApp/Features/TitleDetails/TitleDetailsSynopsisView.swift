//
//  TitleDetailsSynopsisView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsSynopsisView: View {
    private enum Constants {
        static let collapsedLineLimit = 5
    }

    let description: String

    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.ms) {
            SectionHeader(title: StringResource.TitleDetails.descriptionTitle)

            Text(description)
                .font(Typography.body)
                .foregroundStyle(DesignTokens.Colors.textBody)
                .lineSpacing(Spacing.xs)
                .lineLimit(isExpanded ? nil : Constants.collapsedLineLimit)

            Button {
                withAnimation(DesignTokens.Motion.ease) {
                    isExpanded.toggle()
                }
            } label: {
                Text(isExpanded ? StringResource.TitleDetails.collapse : StringResource.TitleDetails.readMore)
                    .font(Typography.captionSemibold)
                    .foregroundStyle(DesignTokens.Colors.primaryLink)
            }
            .buttonStyle(.plain)
        }
    }
}
