import Foundation

extension AuthSessionDTO {
    func toDomain() -> AuthSession {
        AuthSession(accessToken: accessToken, user: user.toDomain())
    }
}

extension UserDTO {
    func toDomain() -> UserProfile {
        UserProfile(
            id: id,
            email: email,
            displayName: displayName,
            avatarURL: avatarUrl.flatMap(URL.init(string:))
        )
    }
}
