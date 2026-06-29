//
//  AuthDTO.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct OTPRequestDTO: Encodable, Sendable {
    let email: String
}

struct OTPVerifyDTO: Encodable, Sendable {
    let email: String
    let code: String
}

struct AuthSessionDTO: Decodable, Sendable {
    let accessToken: String
    let user: UserDTO
}

struct UserDTO: Decodable, Sendable {
    let id: String
    let email: String
    let displayName: String?
    let avatarUrl: String?
}
