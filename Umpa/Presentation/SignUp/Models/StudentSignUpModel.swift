// Created for Umpa in 2025

import Combine
import Domain

final class StudentSignUpModel: ObservableObject, MajorSelectableModel {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var major: Major?
    @Published var dreamCollege0: String?
    @Published var dreamCollege1: String?
    @Published var dreamCollege2: String?

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }

    func validateUserName() -> Bool {
        StudentCreateData.UsernameValidator(rawUsername: username).validate()
    }

    func validateDreamColleges() -> Bool {
        dreamCollege0 != nil && dreamCollege1 != nil && dreamCollege2 != nil
    }
}

extension StudentSignUpModel {
    func toDomain() -> StudentCreateData? {
        return StudentCreateData(
            socialLoginType: socialLoginType,
            name: name,
            username: username,
            major: major,
            dreamCollege0: dreamCollege0 ?? "",
            dreamCollege1: dreamCollege1 ?? "",
            dreamCollege2: dreamCollege2 ?? ""
        )
    }
}

extension StudentSignUpModel: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        StudentSignUpModel(
            socialLoginType: \(socialLoginType),
            name: \(name),
            username: \(username),
            major: \(String(describing: major)),
            dreamCollege0: \(String(describing: dreamCollege0)),
            dreamCollege1: \(String(describing: dreamCollege1)),
            dreamCollege2: \(String(describing: dreamCollege2))
        )
        """
    }
}
