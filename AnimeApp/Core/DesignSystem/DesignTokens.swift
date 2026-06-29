import SwiftUI

enum DesignTokens {
    enum Colors {
        static let background = Color(red: 0.027, green: 0.027, blue: 0.035)
        static let canvas = Color(red: 0.047, green: 0.047, blue: 0.063)
        static let surfaceOne = Color(red: 0.059, green: 0.059, blue: 0.075)
        static let panel = Color(red: 0.067, green: 0.067, blue: 0.082)
        static let surface = Color(red: 0.078, green: 0.078, blue: 0.094)
        static let card = Color(red: 0.082, green: 0.082, blue: 0.106)
        static let elevated = Color(red: 0.102, green: 0.102, blue: 0.133)
        static let chipOn = Color(red: 0.133, green: 0.133, blue: 0.169)
        static let surface04 = Color(red: 0.173, green: 0.173, blue: 0.216)

        static let primary = Color(red: 0.424, green: 0.294, blue: 0.910)
        static let primaryHover = Color(red: 0.557, green: 0.424, blue: 1.000)
        static let primaryLink = Color(red: 0.655, green: 0.545, blue: 1.000)
        static let primaryPress = Color(red: 0.341, green: 0.227, blue: 0.788)
        static let primaryTint = Color(red: 0.486, green: 0.361, blue: 1.000).opacity(0.14)

        static let rating = Color(red: 0.220, green: 0.757, blue: 0.447)
        static let warning = Color(red: 0.949, green: 0.706, blue: 0.239)
        static let danger = Color(red: 1.000, green: 0.353, blue: 0.361)
        static let info = Color(red: 0.302, green: 0.639, blue: 1.000)
        static let gold = Color(red: 0.910, green: 0.773, blue: 0.486)

        static let text = Color.white
        static let textStrong = Color(red: 0.906, green: 0.910, blue: 0.925)
        static let textBody = Color(red: 0.780, green: 0.788, blue: 0.824)
        static let textDim = Color(red: 0.718, green: 0.725, blue: 0.761)
        static let textMuted = Color(red: 0.541, green: 0.549, blue: 0.600)
        static let textFaint = Color(red: 0.494, green: 0.502, blue: 0.549)
        static let textFooter = Color(red: 0.416, green: 0.424, blue: 0.471)

        static let line = Color.white.opacity(0.06)
        static let lineMedium = Color.white.opacity(0.09)
        static let lineStrong = Color.white.opacity(0.18)
        static let hoverOverlay = Color.white.opacity(0.06)
    }

    enum Radius {
        static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 12
        static let extraLarge: CGFloat = 16
        static let twoExtraLarge: CGFloat = 18
        static let full: CGFloat = 999
    }

    enum Spacing {
        static let xsmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xlarge: CGFloat = 24
        static let section: CGFloat = 32
        static let screenGutter: CGFloat = 20
    }

    enum Poster {
        static let aspectRatio: CGFloat = 210 / 297
        static let cornerRadius: CGFloat = Radius.medium
    }

    enum Motion {
        static let fast: Double = 0.12
        static let base: Double = 0.20
        static let slow: Double = 0.32

        static let ease = Animation.timingCurve(0.2, 0.7, 0.2, 1.0, duration: base)
    }

    enum Shadow {
        static let small = Color.black.opacity(0.35)
        static let medium = Color.black.opacity(0.45)
        static let large = Color.black.opacity(0.55)
    }
}
