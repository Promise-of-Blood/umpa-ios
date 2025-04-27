// Created for Umpa in 2025

import Combine
import Domain

final class TeacherSignUpModel: ObservableObject, MajorSelectable {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var major: Major?

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }
}

extension TeacherSignUpModel {
    func toDomain() -> TeacherCreateData? {
        return TeacherCreateData(
            socialLoginType: socialLoginType,
            name: name,
            major: major
        )
    }
}
