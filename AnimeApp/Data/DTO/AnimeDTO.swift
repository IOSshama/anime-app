import Foundation

struct AnimeTitleDTO: Decodable, Sendable {
    let id: String
    let nameRu: String
    let nameJa: String?
    let posterUrl: String?
    let backdropUrl: String?
    let score: Double?
    let status: String?
    let type: String?
    let year: Int?
    let episodesTotal: Int?
    let ageRating: String?
    let descriptionRu: String?
}

struct CatalogPageDTO: Decodable, Sendable {
    let items: [AnimeTitleDTO]
    let page: Int
    let totalPages: Int
    let totalItems: Int
}
