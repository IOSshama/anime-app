//
//  StringResource.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum StringResource {
    enum Tab {
        static var home: String { tr("tab.home", fallback: "Главная") }
        static var catalog: String { tr("tab.catalog", fallback: "Каталог") }
        static var library: String { tr("tab.library", fallback: "Моё") }
        static var profile: String { tr("tab.profile", fallback: "Профиль") }
    }

    enum Route {
        static func collection(_ slug: String) -> String {
            String(format: tr("route.collection", fallback: "Коллекция: %@"), slug)
        }

        static func studio(_ id: String) -> String {
            String(format: tr("route.studio", fallback: "Студия: %@"), id)
        }
    }

    enum Placeholder {
        static var homeTitle: String { tr("placeholder.home.title", fallback: "Главная") }
        static var homeSubtitle: String { tr("placeholder.home.subtitle", fallback: "Server-driven rails будут добавлены после API-интеграции.") }
        static var catalogTitle: String { tr("placeholder.catalog.title", fallback: "Каталог") }
        static var catalogSubtitle: String { tr("placeholder.catalog.subtitle", fallback: "Здесь будет catalog grid, фильтры и пагинация.") }
        static var catalogFiltersTitle: String { tr("placeholder.catalogFilters.title", fallback: "Фильтры") }
        static var catalogFiltersSubtitle: String { tr("placeholder.catalogFilters.subtitle", fallback: "Bottom sheet для draft/applied фильтров каталога.") }
        static var searchTitle: String { tr("placeholder.search.title", fallback: "Поиск") }
        static var searchSubtitle: String { tr("placeholder.search.subtitle", fallback: "Recent queries, popular/personal rows и live results.") }
        static var titleDetailsTitle: String { tr("placeholder.titleDetails.title", fallback: "Тайтл") }
        static func titleDetailsSubtitle(_ id: String) -> String {
            String(format: tr("placeholder.titleDetails.subtitle", fallback: "ID: %@"), id)
        }
        static var playbackTitle: String { tr("placeholder.playback.title", fallback: "Плеер") }
        static func playbackSubtitle(titleId: String, episodeId: String) -> String {
            String(format: tr("placeholder.playback.subtitle", fallback: "Title: %@, episode: %@"), titleId, episodeId)
        }
        static var playbackAutoEpisode: String { tr("placeholder.playback.autoEpisode", fallback: "auto") }
        static var libraryTitle: String { tr("placeholder.library.title", fallback: "Моё") }
        static var librarySubtitle: String { tr("placeholder.library.subtitle", fallback: "Списки, история, оценки и продолжить просмотр.") }
        static var authTitle: String { tr("placeholder.auth.title", fallback: "Вход") }
        static var authSubtitle: String { tr("placeholder.auth.subtitle", fallback: "Email OTP flow и onboarding.") }
        static var profileTitle: String { tr("placeholder.profile.title", fallback: "Профиль") }
        static var profileSubtitle: String { tr("placeholder.profile.subtitle", fallback: "Настройки аккаунта и приложения.") }
    }

    enum DesignSystem {
        static var previewTitle: String { tr("design.preview.title", fallback: "Design System") }
        static var previewSubtitle: String { tr("design.preview.subtitle", fallback: "Базовые компоненты AnimeApp") }
        static var glassTitle: String { tr("design.glass.title", fallback: "Liquid glass surface") }
        static var glassSubtitle: String { tr("design.glass.subtitle", fallback: "Используется для панелей, меню и floating controls.") }
        static var regularGlass: String { tr("design.glass.regular", fallback: "Regular glass") }
        static var strongGlass: String { tr("design.glass.strong", fallback: "Strong glass") }
        static var accentGlass: String { tr("design.glass.accent", fallback: "Accent glass") }
        static var watch: String { tr("action.watch", fallback: "Смотреть") }
        static var watchLater: String { tr("action.watchLater", fallback: "Буду смотреть") }
        static var rate: String { tr("action.rate", fallback: "Оценить") }
        static var poster: String { tr("design.poster", fallback: "Постер") }
        static var sampleAnimeTitle: String { tr("design.sampleAnimeTitle", fallback: "Название аниме") }
        static var sampleOngoing: String { tr("design.sample.ongoing", fallback: "Онгоинг") }
        static var sampleComedy: String { tr("design.sample.comedy", fallback: "Комедия") }
        static var sampleAction: String { tr("design.sample.action", fallback: "Экшен") }
        static var sampleHorror: String { tr("design.sample.horror", fallback: "Хоррор") }
    }

    enum Status {
        static var announced: String { tr("status.announced", fallback: "Анонс") }
        static var ongoing: String { tr("status.ongoing", fallback: "Онгоинг") }
        static var released: String { tr("status.released", fallback: "Вышло") }
        static var planned: String { tr("status.planned", fallback: "Буду") }
        static var watching: String { tr("status.watching", fallback: "Смотрю") }
        static var completed: String { tr("status.completed", fallback: "Просмотрено") }
    }

    enum State {
        static var loading: String { tr("state.loading", fallback: "Загрузка") }
        static var errorTitle: String { tr("state.error.title", fallback: "Не удалось загрузить") }
        static var retry: String { tr("state.retry", fallback: "Повторить") }
        static var emptyTitle: String { tr("state.empty.title", fallback: "Пока пусто") }
    }

    enum Home {
        static var hero: String { tr("home.hero", fallback: "Hero") }
        static var comingSoon: String { tr("home.comingSoon", fallback: "Скоро") }
        static var thisWeek: String { tr("home.thisWeek", fallback: "На этой неделе") }
        static var recentlyUpdated: String { tr("home.recentlyUpdated", fallback: "Обновления") }
        static var top10: String { tr("home.top10", fallback: "Топ 10") }
        static var genres: String { tr("home.genres", fallback: "Жанры") }
        static var studios: String { tr("home.studios", fallback: "Студии") }
        static var all: String { tr("home.all", fallback: "Все") }
        static var details: String { tr("home.details", fallback: "Подробнее") }
        static var noPoster: String { tr("home.noPoster", fallback: "Нет постера") }
        static var sectionCount: String { tr("home.sectionCount", fallback: "Секций: %d") }
        static var heroCount: String { tr("home.heroCount", fallback: "Hero: %d") }
        static var comingSoonCount: String { tr("home.comingSoonCount", fallback: "Скоро: %d") }
        static var genresCount: String { tr("home.genresCount", fallback: "Жанров: %d") }
        static var studiosCount: String { tr("home.studiosCount", fallback: "Студий: %d") }

        static func count(_ format: String, _ count: Int) -> String {
            String(format: format, count)
        }
    }

    enum Meta {
        static var tv: String { tr("meta.type.tv", fallback: "ТВ-сериал") }
        static var movie: String { tr("meta.type.movie", fallback: "Фильм") }
        static var ova: String { tr("meta.type.ova", fallback: "OVA") }
        static var ona: String { tr("meta.type.ona", fallback: "ONA") }
        static var special: String { tr("meta.type.special", fallback: "Спешл") }
        static var music: String { tr("meta.type.music", fallback: "Клип") }
        static var episodes: String { tr("meta.episodes", fallback: "%d серий") }

        static func episodes(_ count: Int) -> String {
            String(format: episodes, count)
        }
    }

    enum Catalog {
        static var total: String { tr("catalog.total", fallback: "Всего: %d") }
        static var page: String { tr("catalog.page", fallback: "Страница %d из %d") }
        static var filters: String { tr("catalog.filters", fallback: "Фильтров: %d") }
        static var filtersTitle: String { tr("catalog.filtersTitle", fallback: "Фильтры") }
        static var showMore: String { tr("catalog.showMore", fallback: "Показать ещё") }
        static var summary: String { tr("catalog.summary", fallback: "Найдено: %d") }
        static var filterTitle: String { tr("catalog.filter.title", fallback: "Фильтры") }
        static var close: String { tr("catalog.filter.close", fallback: "Закрыть") }
        static var applyFilters: String { tr("catalog.filter.apply", fallback: "Применить") }
        static var resetFilters: String { tr("catalog.filter.reset", fallback: "Сбросить") }
        static var sortSection: String { tr("catalog.filter.sort", fallback: "Сортировка") }
        static var genreSection: String { tr("catalog.filter.genre", fallback: "Жанр") }
        static var typeSection: String { tr("catalog.filter.type", fallback: "Тип") }
        static var statusSection: String { tr("catalog.filter.status", fallback: "Статус") }
        static var yearSection: String { tr("catalog.filter.year", fallback: "Год") }
        static var allGenres: String { tr("catalog.filter.allGenres", fallback: "Все жанры") }
        static var allTypes: String { tr("catalog.filter.allTypes", fallback: "Все типы") }
        static var allStatuses: String { tr("catalog.filter.allStatuses", fallback: "Все статусы") }
        static var anyYear: String { tr("catalog.filter.anyYear", fallback: "Любой год") }
        static var unknownOption: String { tr("catalog.filter.unknown", fallback: "Неизвестно") }
        static var sortPopularity: String { tr("catalog.sort.popularity", fallback: "Популярное") }
        static var sortScore: String { tr("catalog.sort.score", fallback: "Оценка") }
        static var sortYear: String { tr("catalog.sort.year", fallback: "Новинки") }
        static var sortName: String { tr("catalog.sort.name", fallback: "Название") }
        static var sortUnderrated: String { tr("catalog.sort.underrated", fallback: "Недооценённое") }
        static var sortRandom: String { tr("catalog.sort.random", fallback: "Случайно") }

        static func total(_ count: Int) -> String {
            String(format: total, count)
        }

        static func page(_ page: Int, totalPages: Int) -> String {
            String(format: self.page, page, totalPages)
        }

        static func filters(_ count: Int) -> String {
            String(format: filters, count)
        }

        static func summary(_ count: Int) -> String {
            String(format: summary, count)
        }
    }

    enum Search {
        static var queryPlaceholder: String { tr("search.query.placeholder", fallback: "Поиск аниме") }
        static var idleTitle: String { tr("search.idle.title", fallback: "Введите запрос") }
        static var results: String { tr("search.results", fallback: "Найдено: %d") }

        static func results(_ count: Int) -> String {
            String(format: results, count)
        }
    }

    enum TitleDetails {
        static var screenshots: String { tr("titleDetails.screenshots", fallback: "Скриншотов: %d") }
        static var trailers: String { tr("titleDetails.trailers", fallback: "Трейлеров: %d") }
        static var characters: String { tr("titleDetails.characters", fallback: "Персонажей: %d") }
        static var similar: String { tr("titleDetails.similar", fallback: "Похожих: %d") }
        static var back: String { tr("titleDetails.back", fallback: "Назад") }
        static var videoUnavailable: String { tr("titleDetails.videoUnavailable", fallback: "Видео пока недоступно") }
        static var descriptionTitle: String { tr("titleDetails.description.title", fallback: "Описание") }
        static var readMore: String { tr("titleDetails.readMore", fallback: "Показать ещё") }
        static var collapse: String { tr("titleDetails.collapse", fallback: "Свернуть") }
        static var screenshotsTitle: String { tr("titleDetails.screenshots.title", fallback: "Скриншоты") }
        static var trailersTitle: String { tr("titleDetails.trailers.title", fallback: "Трейлеры") }
        static var trailer: String { tr("titleDetails.trailer", fallback: "Трейлер") }
        static var charactersTitle: String { tr("titleDetails.characters.title", fallback: "Персонажи") }
        static var character: String { tr("titleDetails.character", fallback: "Персонаж") }
        static var similarTitle: String { tr("titleDetails.similar.title", fallback: "Похожее") }
        static var relatedTitle: String { tr("titleDetails.related.title", fallback: "Связанное") }
        static var franchiseTitle: String { tr("titleDetails.franchise.title", fallback: "Франшиза") }
        static var studio: String { tr("titleDetails.studio", fallback: "Студия") }
        static var nextEpisode: String { tr("titleDetails.nextEpisode", fallback: "Следующая серия") }
        static var minutes: String { tr("titleDetails.minutes", fallback: "%d мин") }

        static func screenshots(_ count: Int) -> String {
            String(format: screenshots, count)
        }

        static func trailers(_ count: Int) -> String {
            String(format: trailers, count)
        }

        static func characters(_ count: Int) -> String {
            String(format: characters, count)
        }

        static func similar(_ count: Int) -> String {
            String(format: similar, count)
        }

        static func minutes(_ count: Int) -> String {
            String(format: minutes, count)
        }
    }

    enum Accessibility {
        static func rating(_ score: String) -> String {
            String(format: tr("accessibility.rating", fallback: "Рейтинг %@"), score)
        }
    }

    enum ErrorMessage {
        static var invalidURL: String { tr("error.invalidURL", fallback: "Некорректный URL") }
        static var invalidResponse: String { tr("error.invalidResponse", fallback: "Некорректный ответ сервера") }
        static func statusCode(_ code: Int) -> String {
            String(format: tr("error.statusCode", fallback: "Сервер вернул код %d"), code)
        }
        static func serverMessage(statusCode: Int, message: String) -> String {
            String(format: tr("error.serverMessage", fallback: "Сервер вернул код %d: %@"), statusCode, message)
        }
        static var decodingFailed: String { tr("error.decodingFailed", fallback: "Не удалось разобрать ответ сервера") }
    }
}

private extension StringResource {
    static func tr(_ key: String, fallback: String) -> String {
        NSLocalizedString(key, tableName: "Localizable", bundle: .main, value: fallback, comment: "")
    }
}
