// Created for Umpa in 2025

import Combine
import Domain
import SwiftUI

final class StudentSignUpModel: ObservableObject {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var major: String?
    @Published var dreamCollege1: String?
    @Published var dreamCollege2: String?
    @Published var dreamCollege3: String?

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }

    func validateUserName() -> Bool {
        StudentCreateData.UsernameValidator(rawUsername: username).validate()
    }

    func validateMajor() -> Bool {
        major != nil
    }
}

extension StudentSignUpModel {
    func toDomain() -> StudentCreateData? {
        return StudentCreateData(
            socialLoginType: socialLoginType,
            name: name,
            username: username,
            major: major ?? "",
            dreamCollege1: dreamCollege1 ?? "",
            dreamCollege2: dreamCollege2 ?? "",
            dreamCollege3: dreamCollege3 ?? ""
        )
    }
}
