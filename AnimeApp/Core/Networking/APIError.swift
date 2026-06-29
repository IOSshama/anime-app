import Foundation

enum APIError: LocalizedError, Sendable {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Некорректный URL"
        case .invalidResponse:
            "Некорректный ответ сервера"
        case .statusCode(let code):
            "Сервер вернул код \(code)"
        case .decodingFailed:
            "Не удалось разобрать ответ сервера"
        }
    }
}
