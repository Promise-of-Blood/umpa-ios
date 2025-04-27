// Created for Umpa in 2025

import Foundation

public struct TeacherCreateData {
    let socialLoginType: SocialLoginType
    let name: String
    let major: String

    public init?(socialLoginType: SocialLoginType, name: String, major: String) {
        self.socialLoginType = socialLoginType
        self.name = name
        self.major = major
    }
}
