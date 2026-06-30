//
//  AnimeAPI.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum AnimeAPI {
    static func home() -> APIEndpoint {
        APIEndpoint(path: "/api/home")
    }

    static func catalog(query: CatalogQuery) -> APIEndpoint {
        APIEndpoint(
            path: "/api/catalog",
            queryItems: query.queryItems
        )
    }

    static func catalogCount() -> APIEndpoint {
        APIEndpoint(path: "/api/catalog/count")
    }

    static func filtersMeta() -> APIEndpoint {
        APIEndpoint(path: "/api/filters/meta")
    }

    static func studios() -> APIEndpoint {
        APIEndpoint(path: "/api/studios")
    }

    static func search(query: SearchQuery) -> APIEndpoint {
        APIEndpoint(path: "/api/search", queryItems: query.queryItems)
    }

    static func titleDetails(id: String) -> APIEndpoint {
        APIEndpoint(path: "/api/titles/\(id)")
    }

    static func franchiseEpisodes(titleId: String) -> APIEndpoint {
        APIEndpoint(path: "/api/titles/\(titleId)/franchise-episodes")
    }
}

private extension CatalogQuery {
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "type", value: type?.rawValue),
            URLQueryItem(name: "status", value: status?.rawValue),
            URLQueryItem(name: "genre", value: genreSlug),
            URLQueryItem(name: "year", value: year.map(String.init)),
            URLQueryItem(name: "studio", value: studioId)
        ].filter { $0.value != nil }
    }
}

private extension SearchQuery {
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: String(pageSize))
        ].filter { $0.value != nil }
    }
}
