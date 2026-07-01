//
//  TitleDetailsCharactersRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsCharactersRail: View {
    private enum Constants {
        static let maxItems = 18
        static let cardWidth: CGFloat = 96
        static let avatarSize: CGFloat = 72
        static let nameLineLimit = 2
        static let roleLineLimit = 1
        static let borderWidth: CGFloat = 1
    }

    let characters: [AnimeCharacter]

    var body: some View {
        if !characters.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                SectionHeader(title: StringResource.TitleDetails.charactersTitle)
                    .padding(.horizontal, Spacing.ml)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: Spacing.md) {
                        ForEach(characters.prefix(Constants.maxItems)) { character in
                            characterCard(character)
                        }
                    }
                    .padding(.horizontal, Spacing.ml)
                    .padding(.vertical, Spacing.sm)
                }
            }
        }
    }

    private func characterCard(_ character: AnimeCharacter) -> some View {
        VStack(spacing: Spacing.sm) {
            HomeRemoteImage(url: character.photoURL)
                .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(DesignTokens.Colors.lineMedium, lineWidth: Constants.borderWidth)
                }

            Text(character.name)
                .font(Typography.captionSemibold)
                .foregroundStyle(DesignTokens.Colors.text)
                .multilineTextAlignment(.center)
                .lineLimit(Constants.nameLineLimit)

            Text(character.seiyuuName ?? character.role ?? StringResource.TitleDetails.character)
                .font(Typography.overline)
                .foregroundStyle(DesignTokens.Colors.textMuted)
                .multilineTextAlignment(.center)
                .lineLimit(Constants.roleLineLimit)
        }
        .frame(width: Constants.cardWidth)
    }
}
