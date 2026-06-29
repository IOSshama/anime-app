//
//  AuthAPI.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum AuthAPI {
    static func requestOTP(email: String) throws -> APIEndpoint {
        let body = try JSONEncoder.animeApp.encode(OTPRequestDTO(email: email))
        return APIEndpoint(path: "/auth/otp/request", method: .post, body: body)
    }

    static func verifyOTP(email: String, code: String) throws -> APIEndpoint {
        let body = try JSONEncoder.animeApp.encode(OTPVerifyDTO(email: email, code: code))
        return APIEndpoint(path: "/auth/otp/verify", method: .post, body: body)
    }

    static func refresh() -> APIEndpoint {
        APIEndpoint(path: "/auth/refresh", method: .post)
    }

    static func logout() -> APIEndpoint {
        APIEndpoint(path: "/auth/logout", method: .post)
    }
}
