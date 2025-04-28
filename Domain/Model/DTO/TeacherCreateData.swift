// Created for Umpa in 2025

import Foundation

public struct TeacherCreateData {
    let socialLoginType: SocialLoginType
    let name: String
    let major: Major
    let gender: Gender
    let region: Region
    let profileImageData: Data?
    let experiences: [Experience]

    public init?(
        socialLoginType: SocialLoginType,
        name: String,
        major: Major?,
        gender: Gender?,
        region: Region?,
        profileImageData: Data?,
        experiences: [Experience],
    ) {
        guard let major,
              let gender,
              let region
        else {
            return nil
        }
        self.socialLoginType = socialLoginType
        self.name = name
        self.major = major
        self.gender = gender
        self.region = region
        self.profileImageData = profileImageData
        self.experiences = experiences
    }
}
