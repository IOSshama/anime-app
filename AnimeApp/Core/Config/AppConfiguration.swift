//
//  AppConfiguration.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct AppConfiguration: Sendable {
    let baseURL: URL
    let keychainServiceName: String

    static let production = AppConfiguration(
        baseURL: URL(string: "https://animesite.org")!,
        keychainServiceName: "com.iosshama.animeapp.auth"
    )
}
