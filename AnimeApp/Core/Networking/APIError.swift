//
//  APIError.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum APIError: LocalizedError, Sendable {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case serverMessage(statusCode: Int, message: String)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            StringResource.ErrorMessage.invalidURL
        case .invalidResponse:
            StringResource.ErrorMessage.invalidResponse
        case .statusCode(let code):
            StringResource.ErrorMessage.statusCode(code)
        case .serverMessage(let statusCode, let message):
            StringResource.ErrorMessage.serverMessage(statusCode: statusCode, message: message)
        case .decodingFailed:
            StringResource.ErrorMessage.decodingFailed
        }
    }
}
