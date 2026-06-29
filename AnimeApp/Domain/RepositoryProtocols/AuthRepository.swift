//
//  AuthRepository.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

protocol AuthRepository: Sendable {
    func requestOTP(email: String) async throws
    func verifyOTP(email: String, code: String) async throws -> AuthSession
    func refresh() async throws -> AuthSession
    func logout() async throws
}

struct AuthSession: Hashable, Sendable {
    let accessToken: String
    let user: UserProfile
}

struct UserProfile: Identifiable, Hashable, Sendable {
    let id: String
    let email: String
    let displayName: String?
    let avatarURL: URL?
}
