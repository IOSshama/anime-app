import Foundation
import Nuke

protocol ImagePipelineService: Sendable {
    func preload(_ urls: [URL])
}

final class NukeImagePipelineService: ImagePipelineService, @unchecked Sendable {
    private let prefetcher = ImagePrefetcher()

    func preload(_ urls: [URL]) {
        prefetcher.startPrefetching(with: urls)
    }
}
