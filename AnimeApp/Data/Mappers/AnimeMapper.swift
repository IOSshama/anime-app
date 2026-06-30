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
            shikimoriId: shikimoriId,
            titleRu: nameRu,
            titleOriginal: nameJa,
            titleEn: nameEn,
            posterURL: AnimeURLMapper.url(from: posterUrl),
            bannerURL: AnimeURLMapper.url(from: backdropUrl),
            rating: score,
            status: AnimeStatus(rawValue: status ?? "") ?? .unknown,
            type: AnimeType(rawValue: type ?? "") ?? .unknown,
            year: year,
            episodeCount: episodesTotal,
            ageRating: ageRating,
            genres: genres?.map { Genre(id: $0, name: $0) } ?? [],
            studio: studios?.first?.toDomain(),
            description: descriptionRu,
            hasCustomPlayer: hasCustomPlayer ?? false
        )
    }
}

extension CatalogPageDTO {
    func toDomain() -> CatalogPage {
        CatalogPage(
            items: items.map { $0.toDomain() },
            page: page,
            pageSize: pageSize,
            totalPages: PaginationMapper.totalPages(totalItems: total, pageSize: pageSize),
            totalItems: total
        )
    }
}

extension HomeDTO {
    func toDomain() -> HomeSections {
        HomeSections(
            hero: hero.map { $0.toDomain() },
            comingSoon: comingSoon.map { $0.toDomain() },
            sections: homeSections,
            topGenres: genres.map { $0.toDomain() },
            studios: studios.map { $0.toDomain() }
        )
    }

    private var homeSections: [HomeSection] {
        let fixedSections = [
            HomeSection(id: "thisWeek", title: "thisWeek", subtitle: nil, titles: thisWeek.map { $0.toDomain() }),
            HomeSection(id: "recentlyUpdated", title: "recentlyUpdated", subtitle: nil, titles: recentlyUpdated.map { $0.toDomain() }),
            HomeSection(id: "top10", title: "top10", subtitle: nil, titles: top10.map { $0.toDomain() })
        ].filter { !$0.titles.isEmpty }

        return fixedSections + rails.map { $0.toDomain() }
    }
}

extension HomeRailDTO {
    func toDomain() -> HomeSection {
        HomeSection(
            id: key,
            title: title,
            subtitle: subtitle,
            titles: items.map { $0.toDomain() }
        )
    }
}

extension UpcomingTitleDTO {
    func toDomain() -> UpcomingTitle {
        UpcomingTitle(
            id: id,
            title: nameRu,
            year: year,
            type: AnimeType(rawValue: type ?? "") ?? .unknown,
            releaseDate: releaseDate,
            trailerKey: trailerKey,
            thumbnailURL: AnimeURLMapper.url(from: thumbnailUrl)
        )
    }
}

extension FiltersMetaDTO {
    func toDomain() -> CatalogFiltersMeta {
        CatalogFiltersMeta(
            genres: genres.map { $0.toDomain() },
            types: types.map { AnimeType(rawValue: $0) ?? .unknown },
            yearRange: years.toDomain()
        )
    }
}

extension GenreDTO {
    func toDomain() -> Genre {
        Genre(id: slug, name: nameRu)
    }
}

extension YearRangeDTO {
    func toDomain() -> YearRange {
        YearRange(min: min, max: max)
    }
}

extension StudioDTO {
    func toDomain() -> Studio {
        Studio(
            id: id ?? name,
            name: name,
            logoURL: AnimeURLMapper.url(from: logoUrl),
            titleCount: titleCount
        )
    }
}

extension TitleDetailsDTO {
    func toDomain() -> AnimeTitleDetails {
        let titleDTO = AnimeTitleDTO(
            id: id,
            shikimoriId: shikimoriId,
            nameRu: nameRu,
            nameJa: nameJa,
            nameEn: nameEn,
            posterUrl: posterUrl,
            backdropUrl: backdropUrl,
            score: score,
            status: status,
            type: type,
            year: year,
            episodesTotal: episodesTotal,
            episodeDuration: episodeDuration,
            ageRating: ageRating,
            descriptionRu: descriptionRu,
            genres: genres,
            studios: studios,
            nextEpisodeAt: nextEpisodeAt,
            sequelAnnounced: sequelAnnounced,
            hasCustomPlayer: hasCustomPlayer
        )

        return AnimeTitleDetails(
            id: id,
            title: titleDTO.toDomain(),
            nextEpisodeAt: nextEpisodeAt,
            sequelAnnounced: sequelAnnounced ?? false,
            episodeDuration: episodeDuration.map(TimeInterval.init),
            ratings: ratings.map { $0.toDomain() },
            characters: characters.map { $0.toDomain() },
            screenshots: screenshots.compactMap { AnimeURLMapper.url(from: $0) },
            trailers: trailers.map { $0.toDomain() },
            similar: similar.map { $0.toDomain() },
            related: related.compactMap { $0.toDomain() },
            franchiseSeasons: franchiseSeasons.map { $0.toDomain() }
        )
    }
}

extension TitleRatingDTO {
    func toDomain() -> TitleRating {
        TitleRating(source: source, score: score, votes: votes)
    }
}

extension AnimeCharacterDTO {
    func toDomain() -> AnimeCharacter {
        AnimeCharacter(
            id: nameRu,
            name: nameRu,
            photoURL: AnimeURLMapper.url(from: photoUrl),
            role: role,
            seiyuuName: seiyuuName
        )
    }
}

extension AnimeTrailerDTO {
    func toDomain() -> AnimeTrailer {
        AnimeTrailer(
            id: "\(provider)-\(externalId)",
            provider: provider,
            externalId: externalId,
            label: label,
            thumbnailURL: AnimeURLMapper.url(from: thumbnailUrl)
        )
    }
}

extension RelatedTitleDTO {
    func toDomain() -> RelatedTitle? {
        guard let id, let nameRu else {
            return nil
        }

        return RelatedTitle(
            id: id,
            title: nameRu,
            relation: relation,
            year: year
        )
    }
}

extension FranchiseSeasonDTO {
    func toDomain() -> FranchiseSeason {
        FranchiseSeason(
            id: id,
            season: season,
            title: nameRu,
            year: year,
            isCurrent: current
        )
    }
}

extension SearchResultDTO {
    func toDomain() -> CatalogPage {
        CatalogPage(
            items: items.map { $0.toDomain() },
            page: page,
            pageSize: pageSize,
            totalPages: PaginationMapper.totalPages(totalItems: total, pageSize: pageSize),
            totalItems: total
        )
    }
}

private enum AnimeURLMapper {
    private static let webBaseURL = URL(string: "https://animesite.org")!

    static func url(from rawValue: String?) -> URL? {
        guard let rawValue, !rawValue.isEmpty else {
            return nil
        }

        if let absoluteURL = URL(string: rawValue), absoluteURL.scheme != nil {
            return absoluteURL
        }

        if rawValue.hasPrefix("/") {
            return URL(string: rawValue, relativeTo: webBaseURL)?.absoluteURL
        }

        return nil
    }
}

private enum PaginationMapper {
    static func totalPages(totalItems: Int, pageSize: Int) -> Int {
        guard pageSize > 0 else {
            return 0
        }

        return Int(ceil(Double(totalItems) / Double(pageSize)))
    }
}
