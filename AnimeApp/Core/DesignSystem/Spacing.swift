//
//  Spacing.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct Spacing {
    static let zero: CGFloat = 0
    static let xxs: CGFloat = 2
    static let xs: CGFloat = DesignTokens.Spacing.xsmall
    static let sm: CGFloat = DesignTokens.Spacing.small
    static let ms: CGFloat = DesignTokens.Spacing.medium
    static let md: CGFloat = DesignTokens.Spacing.large
    static let ml: CGFloat = DesignTokens.Spacing.screenGutter
    static let lg: CGFloat = DesignTokens.Spacing.xlarge
    static let xl: CGFloat = DesignTokens.Spacing.section
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64

    static let screenGutter: CGFloat = DesignTokens.Spacing.screenGutter
}

struct CornerRadius {
    static let none: CGFloat = Spacing.zero
    static let xs: CGFloat = DesignTokens.Radius.small
    static let sm: CGFloat = DesignTokens.Radius.medium
    static let md: CGFloat = DesignTokens.Radius.large
    static let lg: CGFloat = DesignTokens.Radius.extraLarge
    static let xl: CGFloat = DesignTokens.Radius.twoExtraLarge
    static let full: CGFloat = DesignTokens.Radius.full
}

extension EdgeInsets {
    static let zero = EdgeInsets(top: Spacing.zero, leading: Spacing.zero, bottom: Spacing.zero, trailing: Spacing.zero)
    static let small = EdgeInsets(top: Spacing.sm, leading: Spacing.sm, bottom: Spacing.sm, trailing: Spacing.sm)
    static let medium = EdgeInsets(top: Spacing.md, leading: Spacing.md, bottom: Spacing.md, trailing: Spacing.md)
    static let large = EdgeInsets(top: Spacing.lg, leading: Spacing.lg, bottom: Spacing.lg, trailing: Spacing.lg)

    static func horizontal(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: Spacing.zero, leading: value, bottom: Spacing.zero, trailing: value)
    }

    static func vertical(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: Spacing.zero, bottom: value, trailing: Spacing.zero)
    }

    static func all(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }
}
