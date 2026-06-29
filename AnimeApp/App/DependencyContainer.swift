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

    static let live: DependencyContainer = {
        let configuration = AppConfiguration.production
        let apiClient = URLSessionAPIClient(configuration: configuration)
        let authService = KeychainAuthService(serviceName: configuration.keychainServiceName)
        let imagePipeline = NukeImagePipelineService()

        return DependencyContainer(
            configuration: configuration,
            apiClient: apiClient,
            authService: authService,
            imagePipeline: imagePipeline
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
