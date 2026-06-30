//
//  DependencyContainer.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import SwiftUI

struct DependencyContainer {
    let configuration: AppConfiguration
    let apiClient: APIClient
    let authService: AuthService
    let imagePipeline: ImagePipelineService
    let animeRepository: AnimeRepository
    let loadHomeUseCase: LoadHomeUseCase
    let loadCatalogUseCase: LoadCatalogUseCase
    let loadCatalogFiltersUseCase: LoadCatalogFiltersUseCase
    let loadCatalogCountUseCase: LoadCatalogCountUseCase
    let loadStudiosUseCase: LoadStudiosUseCase
    let loadTitleDetailsUseCase: LoadTitleDetailsUseCase
    let searchAnimeUseCase: SearchAnimeUseCase

    static let live: DependencyContainer = {
        let configuration = AppConfiguration.production
        let authService = KeychainAuthService(serviceName: configuration.keychainServiceName)
        let apiClient = URLSessionAPIClient(configuration: configuration, authService: authService)
        let imagePipeline = NukeImagePipelineService()
        let animeRepository = APIAnimeRepository(apiClient: apiClient)

        return DependencyContainer(
            configuration: configuration,
            apiClient: apiClient,
            authService: authService,
            imagePipeline: imagePipeline,
            animeRepository: animeRepository,
            loadHomeUseCase: LoadHomeUseCase(repository: animeRepository),
            loadCatalogUseCase: LoadCatalogUseCase(repository: animeRepository),
            loadCatalogFiltersUseCase: LoadCatalogFiltersUseCase(repository: animeRepository),
            loadCatalogCountUseCase: LoadCatalogCountUseCase(repository: animeRepository),
            loadStudiosUseCase: LoadStudiosUseCase(repository: animeRepository),
            loadTitleDetailsUseCase: LoadTitleDetailsUseCase(repository: animeRepository),
            searchAnimeUseCase: SearchAnimeUseCase(repository: animeRepository)
        )
    }()
}

private struct DependencyContainerKey: EnvironmentKey {
    static let defaultValue: DependencyContainer = .live
}

extension EnvironmentValues {
    var dependencies: DependencyContainer {
        get { self[DependencyContainerKey.self] }
        set { self[DependencyContainerKey.self] = newValue }
    }
}

extension View {
    func withAppDependencies(_ dependencies: DependencyContainer) -> some View {
        environment(\.dependencies, dependencies)
    }
}
