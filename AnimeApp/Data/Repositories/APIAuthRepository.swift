import Foundation

struct APIAuthRepository: AuthRepository {
    let apiClient: APIClient
    let authService: AuthService

    func requestOTP(email: String) async throws {
        try await apiClient.send(try AuthAPI.requestOTP(email: email))
    }

    func verifyOTP(email: String, code: String) async throws -> AuthSession {
        let dto: AuthSessionDTO = try await apiClient.send(try AuthAPI.verifyOTP(email: email, code: code))
        try authService.saveAccessToken(dto.accessToken)
        return dto.toDomain()
    }

    func refresh() async throws -> AuthSession {
        let dto: AuthSessionDTO = try await apiClient.send(AuthAPI.refresh())
        try authService.saveAccessToken(dto.accessToken)
        return dto.toDomain()
    }

    func logout() async throws {
        try await apiClient.send(AuthAPI.logout())
        try authService.clearSession()
    }
}
