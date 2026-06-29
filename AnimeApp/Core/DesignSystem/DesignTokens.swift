import SwiftUI

enum DesignTokens {
    enum Colors {
        static let background = Color(red: 0.027, green: 0.027, blue: 0.035)
        static let canvas = Color(red: 0.047, green: 0.047, blue: 0.063)
        static let surface = Color(red: 0.078, green: 0.078, blue: 0.094)
        static let card = Color(red: 0.082, green: 0.082, blue: 0.106)
        static let elevated = Color(red: 0.102, green: 0.102, blue: 0.133)
        static let primary = Color(red: 0.424, green: 0.294, blue: 0.910)
        static let primaryHover = Color(red: 0.557, green: 0.424, blue: 1.000)
        static let rating = Color(red: 0.220, green: 0.757, blue: 0.447)
        static let warning = Color(red: 0.949, green: 0.706, blue: 0.239)
        static let danger = Color(red: 1.000, green: 0.353, blue: 0.361)
        static let textMuted = Color(red: 0.541, green: 0.549, blue: 0.600)
    }

    enum Radius {
        static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 12
        static let extraLarge: CGFloat = 16
        static let full: CGFloat = 999
    }

    enum Spacing {
        static let xsmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xlarge: CGFloat = 24
        static let section: CGFloat = 32
    }
}
