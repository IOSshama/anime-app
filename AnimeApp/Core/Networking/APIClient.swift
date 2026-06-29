import Foundation

protocol APIClient: Sendable {
    func send<Response: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> Response
    func send(_ endpoint: APIEndpoint) async throws
}

struct URLSessionAPIClient: APIClient {
    private let configuration: AppConfiguration
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        configuration: AppConfiguration,
        session: URLSession = .shared,
        decoder: JSONDecoder = .animeApp
    ) {
        self.configuration = configuration
        self.session = session
        self.decoder = decoder
    }

    func send<Response: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> Response {
        let request = try endpoint.request(baseURL: configuration.baseURL)
        let (data, response) = try await session.data(for: request)
        try validate(response)

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }

    func send(_ endpoint: APIEndpoint) async throws {
        let request = try endpoint.request(baseURL: configuration.baseURL)
        let (_, response) = try await session.data(for: request)
        try validate(response)
    }

    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
    }
}

extension JSONDecoder {
    static let animeApp: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension JSONEncoder {
    static let animeApp: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}
