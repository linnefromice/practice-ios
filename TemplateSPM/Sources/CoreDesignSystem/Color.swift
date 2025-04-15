import SwiftUI
import UIKit

extension UIColor {
    public static func hex(_ hex: UInt) -> UIColor {
        UIColor(
            red: CGFloat((hex & 0xff0000) >> 16) / 255,
            green: CGFloat((hex & 0x00ff00) >> 8) / 255,
            blue: CGFloat(hex & 0x0000ff) / 255,
            alpha: 1
        )
    }

    public static let white1000 = hex(0xffffff)
    public static let black1000 = hex(0x161213)

    public static let systemRed = hex(0xff3d00)
    public static let systemDarkBlue = hex(0x0056fe)
}

extension Color {
    public static func dynamicColor(light: UIColor, dark: UIColor) -> Color {
        Color(UIColor { traitCollection in
            let hex = traitCollection.userInterfaceStyle == .dark ? dark : light
            return hex
        })
    }

    public static let appPrimary = dynamicColor(light: .white1000, dark: .black1000)
    public static let appOnPrimary = dynamicColor(light: .black1000, dark: .white1000)
    public static let appInfo = dynamicColor(light: .systemDarkBlue, dark: .systemRed)

    public struct Theme {
        public static let primary = dynamicColor(light: .white1000, dark: .black1000)
        public static let onPrimary = dynamicColor(light: .black1000, dark: .white1000)
        public static let info = dynamicColor(light: .systemDarkBlue, dark: .systemRed)
    }
}

public typealias AppTheme = Color.Theme