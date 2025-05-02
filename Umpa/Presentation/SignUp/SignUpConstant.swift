// Created for Umpa in 2025

import SwiftUI

enum SignUpConstant {
    static let titleTopPaddingWithoutProgressView: CGFloat = fs(40)
    static let titleTopPaddingWithProgressView: CGFloat = fs(30)
    static let progressViewTopPadding: CGFloat = fs(20)
    static let contentHorizontalPadding: CGFloat = fs(24)
    static let titleColor: Color = UmpaColor.darkBlue
    static let titleFont: Font = .pretendardSemiBold(size: fs(22))
    static let backButtonPadding: CGFloat = fs(8)

    /// 인증 코드 유효 시간(초)
    static let verificationCodeExpirationTime: Int = 180
}
