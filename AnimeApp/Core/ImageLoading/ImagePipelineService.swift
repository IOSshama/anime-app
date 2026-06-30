//
//  ImagePipelineService.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation
import Nuke

protocol ImagePipelineService: Sendable {
    func preload(_ urls: [URL])
}

final class NukeImagePipelineService: ImagePipelineService, @unchecked Sendable {
    private let prefetcher = ImagePrefetcher()

    func preload(_ urls: [URL]) {
        prefetcher.startPrefetching(with: urls.removingDuplicates())
    }
}

private extension Array where Element == URL {
    func removingDuplicates() -> [URL] {
        var seenURLs = Set<URL>()

        return filter { url in
            seenURLs.insert(url).inserted
        }
    }
}
