# Архитектура iOS-приложения для AnimeSite

## 1. Основа решения

Целевая схема: нативное SwiftUI-приложение поверх существующего backend AnimeSite.

- У сайта уже есть production backend на NestJS.
- API-контракты лежат в `packages/types` и описаны через `zod`/TypeScript types.
- Backend уже умеет каталог, поиск, авторизацию, библиотеку, рекомендации, календарь, уведомления и плеер.
- Backend нормализует данные из Shikimori, AniList, Kitsu, MAL/Jikan, IMDb, OMDb, TMDB, Kodik, AniLibria и AniSkip.
- iOS-приложение должно строиться от реальных API-контрактов backend, а не от HTML-страниц.
- Mobile BFF добавляется только если текущие endpoint'ы слишком завязаны на web.

## 2. Что есть у сайта

По анализу production-сайта, README и frontend-репозитория:

- Главная: hero-карусель, новые серии, расписание, студии, сезонные подборки, популярное, жанровые коллекции, рекомендации.
- Каталог: фильтры по году, типу, жанру, статусу, длине, возрастному рейтингу, рейтингу; сортировка; live count; подгрузка еще.
- Поиск: header search/overlay, быстрый вызов `Cmd/Ctrl + K`, популярное до ввода, история/персональные строки для авторизованного пользователя, live results.
- Страница тайтла: постер, ambient hero, рейтинг, оригинальное название, статус, студия, описание, жанры, сезоны, серии, скриншоты, персонажи, трейлеры, похожее.
- Плеер: Kodik iframe + AniLibria HLS, отдельный выбор озвучки и плеера, субтитры в контракте, AniSkip, прогресс просмотра, autoplay next.
- Аккаунт: текущий frontend использует email OTP flow; Google OAuth включается флагом `NEXT_PUBLIC_GOOGLE_AUTH_ENABLED`.
- Библиотека: списки, рейтинги, watch-later, история, продолжить просмотр, подписки на новые серии.
- Рекомендации: персональная модель, onboarding после нового аккаунта, rails для `For You`.
- Календарь и уведомления: расписание ongoing-релизов и подписки на новые серии.

## 3. Рекомендуемый стек iOS

- UI: SwiftUI.
- Архитектура: feature-based MVVM + тонкий Domain/Data слой.
- Навигация: `NavigationStack` + tab shell.
- Состояние: `@Observable` для iOS 17+.
- Асинхронность: `async/await`.
- Сеть: `URLSession` + typed API client.
- Хранение токенов: Keychain.
- Локальный cache/user state: SwiftData.
- Изображения: Nuke или Kingfisher.
- Видео: AVKit/AVPlayer для HLS.
- Iframe fallback: WKWebView для Kodik, если native stream недоступен.
- Push: APNs для новых серий.

Минимальная цель: iOS 17+.

## 4. Дизайн-система из frontend-кода

Источник: `apps/web/app/globals.css`, `apps/web/lib/glass.ts`, компоненты `SiteHeader`, `AnimeCard`, `HeroSlider`, `CatalogFilters`, `TitlePage`, `NativePlayer`, `AuthModal`, `SearchBox`.

### Визуальный язык

- Название системы в комментариях frontend: `эфир`.
- Основной стиль: темная immersive UI + `liquid-glass` поверхности.
- Базовый фон: `#070709`.
- Основные поверхности: `#0c0c10`, `#0f0f13`, `#111115`, `#141418`, `#15151b`, `#1a1a22`.
- Основной action color: violet `#6c4be8`.
- Hover/action accent: `#8e6cff`, link accent `#a78bff`.
- Rating color: green `#38c172`.
- Warning: `#f2b43d`.
- Danger: `#ff5a5c`.
- Text scale: white, strong, body, dim, muted, faint.
- Radii: 6, 10, 12, 16, 18, full pill.
- Motion: 120 ms, 200 ms, 320 ms, easing `cubic-bezier(0.2, 0.7, 0.2, 1)`.
- Fonts in web: `Inter`, `SF Pro Display`, system Apple fonts.

### Liquid Glass

- `liquid-glass` использует полупрозрачный dark surface, blur, saturation, inset highlight и rim light.
- Есть варианты `glass-strong` и `glass-accent`.
- В iOS design system нужны аналоги:
  - `GlassSurface`
  - `PrimaryButton`
  - `IconGlassButton`
  - `StatusPill`
  - `RatingBadge`
  - `PosterCard`
  - `FilterChip`
  - `SegmentedPill`
  - `BottomSheet`

### Навигация

- Desktop web: fixed transparent header, glass islands, centered nav pill, search island, profile/login справа.
- Header прячется при scroll down и появляется при scroll up.
- На detail pages есть back affordance слева.
- Mobile web: нижний tab bar с тремя разделами: `Главная`, `Каталог`, `Моё`.
- Watch route скрывает глобальный header/footer/mobile tab.
- Для iOS основной shell:
  - `Главная`
  - `Каталог`
  - `Моё`
  - `Профиль`
- Search лучше держать глобальным action в navigation bar/search overlay, а не отдельным tab на MVP.

### Карточки аниме

- Poster aspect ratio: 210:297.
- На карточке есть rating badge, announced badge, personal status badge.
- Desktop hover показывает scrim, actions rail, meta и кнопку `Смотреть`.
- На touch/mobile hover-слой скрывается.
- Для iOS:
  - tap по карточке открывает TitleDetails;
  - long press/context menu открывает действия `Буду смотреть`, `Просмотрено`, `Оценить`, `Неинтересно`;
  - быстрый `Смотреть` можно показывать на detail screen и в continue watching;
  - status/rating badges остаются видимыми без hover.

### Главная

- Web home состоит из server-driven rails: hero, continue watching, watch later, for you, recently updated, schedule, studios, trailers, genre rails.
- Desktop hero широкий и атмосферный.
- Mobile hero в коде сделан как poster-first carousel с horizontal scroll snap, ambient blur от активного poster и соседними poster preview.
- Для iOS Home должен принимать секции с backend и рендерить их компонентами rails/carousel без хардкода списка подборок.

### Каталог

- Фильтры:
  - год `from/to`;
  - тип multi-select;
  - жанр tri-state: neutral/include/exclude;
  - `genreMatch`: all/any;
  - статус multi-select;
  - длина;
  - возрастной рейтинг;
  - rating range 0...10;
  - sort;
  - hide watched для авторизованного пользователя.
- Есть debounced live count `Показать (N)`.
- Есть reset и quick toggles.
- Catalog results сохраняют scroll/grid state при возврате со страницы тайтла.
- Для iOS фильтры лучше вынести в bottom sheet с applied/draft state.

### Страница тайтла

- Hero подтянут под fixed header.
- Фон строится от backdrop/screenshot/poster или poster accent color.
- Focal image: vertical poster.
- На poster есть score badge и personal status badge.
- Actions: `Смотреть`, bookmark/follow, more menu, rating.
- Episodes section использует весь franchise episode list, сгруппированный по сезонам и extras.
- Mobile web скрывает desktop header на detail, показывает top-left back button поверх hero и переносит описание ниже эпизодов.
- Для iOS TitleDetails:
  - large poster hero;
  - metadata chips;
  - primary watch CTA;
  - library/status actions;
  - grouped franchise episodes;
  - screenshots/trailers/characters/similar rails.

### Плеер

- В контракте есть два разных выбора: `audioTracks` и player/provider.
- `PlaybackResponse.kind = embed | hls`.
- `embed` рендерится через Kodik iframe.
- `hls` рендерится через custom player для AniLibria.
- Web `NativePlayer` поддерживает:
  - play/pause;
  - seek +/- 10 seconds;
  - next episode;
  - volume/mute;
  - speed 0.5...2.0;
  - quality ladder;
  - episodes panel;
  - player/provider panel;
  - settings panel;
  - scrubber preview;
  - buffered/played progress;
  - intro/outro skip;
  - auto-skip opening;
  - end card/autoplay next;
  - fullscreen;
  - keyboard shortcuts.
- Для iOS HLS должен идти через AVPlayer с custom overlay.
- Kodik остается fallback через WKWebView.
- Прогресс отправляется heartbeat'ом и при уходе приложения в background.

### Auth

- Текущий frontend flow:
  - step `choose`;
  - step `email`;
  - step `code`;
  - step `onboarding`.
- Email OTP endpoints: request code и verify code.
- Google доступен только если включен env flag.
- После нового аккаунта frontend проверяет рекомендации и может открыть onboarding.
- Auth modal использует split layout: форма + showcase `Зачем аккаунт`.
- Для iOS:
  - email OTP;
  - Sign in with Google, если backend включит OAuth для mobile;
  - refresh token/session;
  - Keychain;
  - onboarding после первой авторизации.

### Search

- Header search раскрывается из glass island.
- Есть debounce 200 ms.
- Empty state:
  - для guest: популярное;
  - для authed: continue/history rows.
- Есть local search history.
- Есть keyboard navigation на web.
- Submit ведет на `/search?q=...`.
- Для iOS нужен search overlay/search screen с recent queries, popular/personal rows и live results.

### Accessibility/performance

- В CSS есть поддержка `prefers-reduced-motion`.
- Есть `prefers-reduced-transparency` fallback для glass.
- Есть `lite-mode.css`, который отключает blur, shadows, transitions, animations и shimmer для слабых устройств/TV.
- В iOS нужны настройки respect Reduce Motion/Reduce Transparency.

## 5. Структура проекта

```text
AnimeApp
  App
    AnimeApp.swift
    AppRouter.swift
    DependencyContainer.swift

  Core
    Networking
    Auth
    Persistence
    ImageLoading
    Player
    DesignSystem

  Domain
    Entities
    UseCases
    RepositoryProtocols

  Data
    API
    DTO
    Mappers
    Repositories
    LocalStores

  Features
    Home
    Catalog
    Search
    TitleDetails
    Playback
    Library
    Auth
    Profile
```

Правило зависимостей:

```text
Features -> Domain -> RepositoryProtocols
Data -> Domain
App -> собирает зависимости
Core -> общая инфраструктура
```

UI не должен знать raw DTO с backend. DTO мапятся в domain-модели.

## 6. Главная навигация

Основной tab shell:

- `Главная`
- `Каталог`
- `Моё`
- `Профиль`

Маршруты:

```swift
enum AppRoute: Hashable {
    case titleDetails(id: String)
    case player(titleId: String, episodeId: String?)
    case auth
    case catalogFilter
    case collection(slug: String)
    case studio(id: String)
}
```

## 7. Основные модели

```swift
struct AnimeTitle: Identifiable, Hashable {
    let id: String
    let titleRu: String
    let titleOriginal: String?
    let posterURL: URL?
    let bannerURL: URL?
    let rating: Double?
    let status: AnimeStatus
    let type: AnimeType
    let year: Int?
    let episodeCount: Int?
    let ageRating: String?
    let genres: [Genre]
    let studio: Studio?
    let description: String?
}

struct Episode: Identifiable, Hashable {
    let id: String
    let titleId: String
    let number: Int
    let seasonNumber: Int?
    let title: String?
    let thumbnailURL: URL?
    let rating: Double?
    let duration: TimeInterval?
    let releasedAt: Date?
    let hasStream: Bool
    let progress: EpisodeProgress?
}

struct EpisodeGroup: Identifiable, Hashable {
    let id: String
    let titleId: String
    let title: String
    let kind: EpisodeGroupKind
    let seasonNumber: Int?
    let episodes: [Episode]
}

struct AudioTrack: Identifiable, Hashable {
    let id: String
    let studioName: String
    let kind: AudioKind
    let language: String
    let isPremium: Bool
    let isAvailable: Bool
    let provider: PlaybackProvider
}

struct SubtitleTrack: Identifiable, Hashable {
    let id: String
    let label: String
    let language: String
    let isForced: Bool
    let isAvailable: Bool
}

struct PlaybackSource: Hashable {
    let quality: PlaybackQuality
    let url: URL
    let type: PlaybackSourceType
}

struct PlaybackSession: Hashable {
    let kind: PlaybackKind
    let episode: Episode
    let embedURL: URL?
    let hlsSources: [PlaybackSource]
    let audioTracks: [AudioTrack]
    let subtitleTracks: [SubtitleTrack]
    let selectedAudioTrackId: String?
    let selectedSubtitleTrackId: String?
    let selectedQuality: PlaybackQuality
    let skip: SkipMarkers?
    let nextEpisodeId: String?
    let resumePosition: TimeInterval?
    let autoplayNext: Bool
    let autoSkipOpening: Bool
}

struct UserTitleState: Hashable {
    let titleId: String
    var listStatus: LibraryStatus?
    var isFollowing: Bool
    var lastEpisodeId: String?
    var progressSeconds: TimeInterval
}
```

## 8. Backend/API стратегия

Правильная стратегия:

1. Получить актуальные исходники backend.
2. Посмотреть `packages/types`.
3. Понять реальные API-контракты.
4. Сделать Swift DTO под эти контракты.
5. Собрать repositories в iOS поверх существующего API.

Ориентировочные endpoint'ы, которые нужны iOS:

```text
GET  /home
GET  /catalog
GET  /catalog/count
GET  /catalog/facets
GET  /search
GET  /titles/{id}
GET  /titles/{id}/episodes
GET  /titles/{id}/franchise-episodes
GET  /titles/{id}/media
GET  /titles/{id}/related
GET  /titles/{titleId}/episodes/{episodeId}/playback

POST /auth/otp/request
POST /auth/otp/verify
POST /auth/refresh
POST /auth/logout

GET  /me/library
PUT  /me/library/{titleId}
POST /me/progress
GET  /me/history
PUT  /me/follows/{titleId}
GET  /me/recommendations
```

Названия могут отличаться. Источник правды - backend repo и `packages/types`.

## 9. Контракты playback из `packages/types`

Ключевые типы:

- `AudioTrackDto`
  - `id`
  - `studioName`
  - `kind`
  - `language`
  - `isPremium`
  - `available`
  - `provider: kodik | anilibria`
  - `popularity`
- `SubtitleTrackDto`
  - `id`
  - `label`
  - `language`
  - `isForced`
  - `available`
- `EpisodeListItem`
  - `id`
  - `titleId`
  - `season`
  - `number`
  - `nameRu`
  - `thumbnailUrl`
  - `durationMin`
  - `rating`
  - `isPremium`
  - `hasStream`
  - `progress`
- `FranchiseEpisodesResponse`
  - `seasons`
  - `extras`
  - `hasStreams`
  - `watchedCount`
  - `episodes`
- `PlaybackResponse`
  - `episode`
  - `embedUrl`
  - `kind: embed | hls`
  - `hls.sources`
  - `audioTracks`
  - `subtitleTracks`
  - `selected`
  - `qualities`
  - `skip`
  - `next`
  - `resume`
  - `autoplayNext`
  - `autoSkipOpening`
  - `upsell`
- `ProgressInput`
  - `episodeId`
  - `positionS`
  - `durationS`
  - `audioTrackId`
  - `subtitleTrackId`

## 10. Плеер в iOS

Плеер - самая важная и самая рискованная часть.

Главная особенность сайта: пользователь выбирает `Озвучку` и `Плеер` независимо.

Для iOS это значит:

- `AudioTrack` не должен быть жестко привязан к экранному picker'у provider.
- `PlaybackProvider` должен быть отдельной сущностью.
- AniLibria/HLS нужно играть через `AVPlayer`.
- Kodik iframe держать как fallback через `WKWebView`.
- AniSkip хранить как `SkipMarkers`.
- Прогресс отправлять на backend каждые 10-20 секунд и при уходе приложения в background.
- Selected audio/subtitle/quality сохранять между эпизодами.

Компоненты:

```text
PlaybackFeature
  PlayerView
  PlayerViewModel
  NativeHLSPlayer
  WebIframePlayer
  PlayerControlsOverlay
  AudioTrackPicker
  SubtitleTrackPicker
  ProviderPicker
  EpisodePicker
  QualityPicker
  SpeedPicker
  SkipIntroButton
  NextEpisodeCard
```

## 11. Главные фичи

### Home

Секции:

- hero carousel;
- continue watching;
- watch later;
- for you;
- recently updated;
- schedule;
- studios;
- seasonal rails;
- popular;
- genre rails;
- trailers.

Home должен приходить с backend как список секций, чтобы не хардкодить десятки подборок в приложении.

### Catalog

Нужно поддержать:

- фильтры;
- sort;
- live count;
- pagination/load more;
- быстрые фильтры;
- genre include/exclude;
- hide watched;
- сохранение scroll position и loaded pages при возврате из TitleDetails;
- optimistic action для `Буду смотреть`.

### Search

Нужно поддержать:

- popular results до ввода;
- personal/history rows для авторизованного пользователя;
- debounce 200-500 ms;
- live results;
- recent queries;
- переход в TitleDetails;
- переход на полный экран результатов.

### TitleDetails

Экран должен включать:

- hero/poster;
- ambient background;
- метаданные;
- жанры;
- описание с `Показать ещё`;
- действия `Начать просмотр`, `Буду смотреть`, `Следить`, `Оценить`;
- franchise episode groups;
- скриншоты;
- персонажи;
- трейлеры;
- похожее.

### Library

Без логина показывать auth gate.

После логина:

- watch-later;
- watching;
- completed;
- history;
- ratings;
- followed titles;
- continue watching.

### Auth

Слой auth должен поддерживать:

- email OTP request;
- email OTP verify;
- Google Sign-In, если backend включает mobile OAuth;
- refresh token;
- logout;
- Keychain storage;
- onboarding после нового аккаунта.

Email/password добавляется только если актуальный backend contract это поддерживает.

## 12. MVP

Минимальный MVP:

1. Каталог.
2. Поиск.
3. Страница тайтла.
4. Список сезонов/серий.
5. Плеер с выбором provider + озвучки.
6. Прогресс просмотра.
7. Авторизация через email OTP.
8. `Буду смотреть` / watch-later.

После MVP:

- главная со всеми подборками;
- рекомендации;
- календарь;
- push-уведомления;
- импорт MAL/YummyAnime/text/JSON/HTML;
- расширенная история и оценки;
- onboarding;
- офлайн-cache poster/metadata.
