//
//  HomeContentRail.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct HomeContentRail: View {
    let title: String
    let items: [AnimeTitle]
    let onSelect: (AnimeTitle) -> Void
    var onShowAll: (() -> Void)?

    var body: some View {
        if !items.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HomeRailHeader(title: title, action: onShowAll)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: Spacing.md) {
                        ForEach(items) { item in
                            HomeAnimePosterCard(title: item) {
                                onSelect(item)
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.ml)
                    .padding(.vertical, Spacing.sm)
                }
            }
        }
    }
}
