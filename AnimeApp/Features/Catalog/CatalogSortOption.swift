//
//  CatalogSortOption.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum CatalogSortOption: CaseIterable, Identifiable {
    case popularity
    case score
    case year
    case name
    case underrated
    case random

    var id: CatalogSort { sort }

    var sort: CatalogSort {
        switch self {
        case .popularity:
            .popularity
        case .score:
            .score
        case .year:
            .year
        case .name:
            .name
        case .underrated:
            .underrated
        case .random:
            .random
        }
    }

    var title: String {
        switch self {
        case .popularity:
            StringResource.Catalog.sortPopularity
        case .score:
            StringResource.Catalog.sortScore
        case .year:
            StringResource.Catalog.sortYear
        case .name:
            StringResource.Catalog.sortName
        case .underrated:
            StringResource.Catalog.sortUnderrated
        case .random:
            StringResource.Catalog.sortRandom
        }
    }

    var systemImage: String {
        switch self {
        case .popularity:
            "flame.fill"
        case .score:
            "star.fill"
        case .year:
            "calendar"
        case .name:
            "textformat"
        case .underrated:
            "sparkles"
        case .random:
            "shuffle"
        }
    }
}
