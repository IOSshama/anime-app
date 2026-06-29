//
//  AnimeMapper.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

extension AnimeTitleDTO {
    func toDomain() -> AnimeTitle {
        AnimeTitle(
            id: id,
            titleRu: nameRu,
            titleOriginal: nameJa,
            posterURL: posterUrl.flatMap(URL.init(string:)),
            bannerURL: backdropUrl.flatMap(URL.init(string:)),
            rating: score,
            status: AnimeStatus(rawValue: status ?? "") ?? .unknown,
            type: AnimeType(rawValue: type ?? "") ?? .unknown,
            year: year,
            episodeCount: episodesTotal,
            ageRating: ageRating,
            genres: [],
            studio: nil,
            description: descriptionRu
        )
    }
}
