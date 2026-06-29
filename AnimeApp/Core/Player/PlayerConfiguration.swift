import Foundation

struct PlayerConfiguration: Sendable {
    var progressHeartbeatSeconds: TimeInterval = 15
    var seekStepSeconds: TimeInterval = 10
    var defaultAutoplayNext: Bool = true
}
