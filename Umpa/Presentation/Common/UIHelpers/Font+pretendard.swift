// Created for Umpa in 2025

import SwiftUI

public extension Font {
    static func pretendardExtraBold(size: CGFloat) -> Font {
        return Font(UIFont.pretendardExtraBold(size: size))
    }

    static func pretendardBold(size: CGFloat) -> Font {
        return Font(UIFont.pretendardBold(size: size))
    }

    static func pretendardSemiBold(size: CGFloat) -> Font {
        return Font(UIFont.pretendardSemiBold(size: size))
    }

    static func pretendardMedium(size: CGFloat) -> Font {
        return Font(UIFont.pretendardMedium(size: size))
    }

    static func pretendardRegular(size: CGFloat) -> Font {
        return Font(UIFont.pretendardRegular(size: size))
    }
}

public extension UIFont {
    static func pretendardExtraBold(size: CGFloat) -> UIFont {
        let maybeFont = UIFont(name: "Pretendard-ExtraBold", size: size)
        if let font = maybeFont {
            return font
        } else {
            return UIFont.systemFont(ofSize: size, weight: .heavy)
        }
    }

    static func pretendardBold(size: CGFloat) -> UIFont {
        let maybeFont = UIFont(name: "Pretendard-Bold", size: size)
        if let font = maybeFont {
            return font
        } else {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }

    static func pretendardSemiBold(size: CGFloat) -> UIFont {
        let maybeFont = UIFont(name: "Pretendard-SemiBold", size: size)
        if let font = maybeFont {
            return font
        } else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
    }

    static func pretendardMedium(size: CGFloat) -> UIFont {
        let maybeFont = UIFont(name: "Pretendard-Medium", size: size)
        if let font = maybeFont {
            return font
        } else {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
    }

    static func pretendardRegular(size: CGFloat) -> UIFont {
        let maybeFont = UIFont(name: "Pretendard-Regular", size: size)
        if let font = maybeFont {
            return font
        } else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}
