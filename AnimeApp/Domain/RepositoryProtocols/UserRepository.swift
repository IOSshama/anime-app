//
//  UserRepository.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

protocol UserRepository: Sendable {
    func library() async throws -> [UserTitleState]
    func updateLibrary(titleId: String, status: LibraryStatus?) async throws
    func saveProgress(episodeId: String, position: TimeInterval, duration: TimeInterval?) async throws
    func follow(titleId: String, enabled: Bool) async throws
}
