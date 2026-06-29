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
        static var decodingFailed: String { tr("error.decodingFailed", fallback: "Не удалось разобрать ответ сервера") }
    }
}

private extension StringResource {
    static func tr(_ key: String, fallback: String) -> String {
        NSLocalizedString(key, tableName: "Localizable", bundle: .main, value: fallback, comment: "")
    }
}
