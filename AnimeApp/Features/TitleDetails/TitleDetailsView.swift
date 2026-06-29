//
//  TitleDetailsView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct TitleDetailsView: View {
    let titleId: String

    var body: some View {
        PlaceholderFeatureView(
            title: StringResource.Placeholder.titleDetailsTitle,
            subtitle: StringResource.Placeholder.titleDetailsSubtitle(titleId)
        )
    }
}
