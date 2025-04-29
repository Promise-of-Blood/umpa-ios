// Created for Umpa in 2025

import Foundation

public struct TeacherCreateData {
    let socialLoginType: SocialLoginType
    let name: String
    let major: Major

    public init?(socialLoginType: SocialLoginType, name: String, major: Major?) {
        guard let major else {
            return nil
        }
        self.socialLoginType = socialLoginType
        self.name = name
        self.major = major
    }
}
