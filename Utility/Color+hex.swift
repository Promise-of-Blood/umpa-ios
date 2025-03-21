import SwiftUI

extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a: UInt64
        let r: UInt64
        let g: UInt64
        let b: UInt64

        switch hex.count {
        case 6: // RGB (예: "9E9E9E")
            (a, r, g, b) = (
                255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF
            )
        case 8: // ARGB (예: "FF9E9E9E")
            (a, r, g, b) = (
                (int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF,
                int & 0xFF
            )
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
