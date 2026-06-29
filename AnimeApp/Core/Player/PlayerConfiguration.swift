//
//  PlayerConfiguration.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

struct PlayerConfiguration: Sendable {
    var progressHeartbeatSeconds: TimeInterval = 15
    var seekStepSeconds: TimeInterval = 10
    var defaultAutoplayNext: Bool = true
}
