import Foundation

enum AnimeAPI {
    static func home() -> APIEndpoint {
        APIEndpoint(path: "/home")
    }

    static func catalog(query: CatalogQuery) -> APIEndpoint {
        APIEndpoint(
            path: "/catalog",
            queryItems: [
                URLQueryItem(name: "page", value: String(query.page)),
                URLQueryItem(name: "q", value: query.search),
                URLQueryItem(name: "sort", value: query.sort)
            ].filter { $0.value != nil }
        )
    }

    static func search(query: String) -> APIEndpoint {
        APIEndpoint(path: "/search", queryItems: [URLQueryItem(name: "q", value: query)])
    }

    static func titleDetails(id: String) -> APIEndpoint {
        APIEndpoint(path: "/titles/\(id)")
    }

    static func franchiseEpisodes(titleId: String) -> APIEndpoint {
        APIEndpoint(path: "/titles/\(titleId)/franchise-episodes")
    }
}
