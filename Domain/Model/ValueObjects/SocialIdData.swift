// Created for Umpa in 2025

import Foundation

public struct SocialIdData {
    public let socialLoginType: SocialLoginType
    public let userId: String

    public init(socialLoginType: SocialLoginType, userId: String = "") {
        self.socialLoginType = socialLoginType
        self.userId = userId
    }
}
