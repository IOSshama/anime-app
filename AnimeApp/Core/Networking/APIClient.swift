//
//  APIClient.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

protocol APIClient: Sendable {
    func send<Response: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> Response
    func send(_ endpoint: APIEndpoint) async throws
}

struct URLSessionAPIClient: APIClient {
    private let configuration: AppConfiguration
    private let session: URLSession
    private let decoder: JSONDecoder
    private let authService: AuthService?

    init(
        configuration: AppConfiguration,
        session: URLSession = .shared,
        decoder: JSONDecoder = .animeApp,
        authService: AuthService? = nil
    ) {
        self.configuration = configuration
        self.session = session
        self.decoder = decoder
        self.authService = authService
    }

    func send<Response: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> Response {
        let request = try makeRequest(for: endpoint)
        let (data, response) = try await session.data(for: request)
        try validate(response, data: data)

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }

    func send(_ endpoint: APIEndpoint) async throws {
        let request = try makeRequest(for: endpoint)
        let (data, response) = try await session.data(for: request)
        try validate(response, data: data)
    }

    private func makeRequest(for endpoint: APIEndpoint) throws -> URLRequest {
        var request = try endpoint.request(baseURL: configuration.baseURL)

        if endpoint.requiresAuthorization, let token = try authService?.accessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

    private func validate(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            if let serverError = try? decoder.decode(APIServerErrorDTO.self, from: data) {
                throw APIError.serverMessage(statusCode: httpResponse.statusCode, message: serverError.message)
            }
            throw APIError.statusCode(httpResponse.statusCode)
        }
    }
}

extension JSONDecoder {
    static let animeApp: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)

            let fractionalFormatter = ISO8601DateFormatter()
            fractionalFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime]

            if let date = fractionalFormatter.date(from: rawValue) ?? formatter.date(from: rawValue) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid ISO8601 date"
            )
        }
        return decoder
    }()
}

private struct APIServerErrorDTO: Decodable {
    let message: String
}

extension JSONEncoder {
    static let animeApp: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}
