//
//  AppRoute.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum AppRoute: Hashable {
    case titleDetails(id: String)
    case player(titleId: String, episodeId: String?)
    case collection(slug: String)
    case studio(id: String)
}

enum AppSheet: Identifiable {
    case auth
    case catalogFilter

    var id: String {
        switch self {
        case .auth:
            "auth"
        case .catalogFilter:
            "catalogFilter"
        }
    }
}
