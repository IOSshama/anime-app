//
//  CatalogFilterPlaceholderView.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct CatalogFilterPlaceholderView: View {
    var body: some View {
        PlaceholderFeatureView(
            title: StringResource.Placeholder.catalogFiltersTitle,
            subtitle: StringResource.Placeholder.catalogFiltersSubtitle
        )
    }
}
