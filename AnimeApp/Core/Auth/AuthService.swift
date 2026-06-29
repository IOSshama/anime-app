import Foundation
@preconcurrency import KeychainAccess

protocol AuthService: Sendable {
    func accessToken() throws -> String?
    func saveAccessToken(_ token: String) throws
    func clearSession() throws
}

final class KeychainAuthService: AuthService, @unchecked Sendable {
    private let keychain: Keychain
    private let accessTokenKey = "accessToken"

    init(serviceName: String) {
        self.keychain = Keychain(service: serviceName)
            .accessibility(.afterFirstUnlockThisDeviceOnly)
    }

    func accessToken() throws -> String? {
        try keychain.get(accessTokenKey)
    }

    func saveAccessToken(_ token: String) throws {
        try keychain.set(token, key: accessTokenKey)
    }

    func clearSession() throws {
        try keychain.remove(accessTokenKey)
    }
}
