//
//  Typography.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct Typography {
    static let display = Font.system(size: 32, weight: .bold)
    static let titleLarge = Font.system(size: 24, weight: .bold)
    static let title = Font.system(size: 20, weight: .semibold)
    static let sectionTitle = Font.system(size: 19, weight: .semibold)
    static let headline = Font.system(size: 17, weight: .semibold)
    static let body = Font.system(size: 15, weight: .regular)
    static let bodySemibold = Font.system(size: 15, weight: .semibold)
    static let subheadline = Font.system(size: 14, weight: .regular)
    static let subheadlineSemibold = Font.system(size: 14, weight: .semibold)
    static let caption = Font.system(size: 13, weight: .regular)
    static let captionSemibold = Font.system(size: 13, weight: .semibold)
    static let badge = Font.system(size: 12, weight: .semibold)
    static let badgeBold = Font.system(size: 12, weight: .bold, design: .rounded)
    static let overline = Font.system(size: 11, weight: .semibold)
    static let button = Font.system(size: 15, weight: .semibold)
}
