// Created for Umpa in 2025

import Combine
import Domain

final class TeacherSignUpModel: ObservableObject, MajorSelectableModel {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var major: Major?
    @Published var gender: Gender?
    @Published var lessonRegion: Region?
    @Published var profileImageData: Data?
    @Published var experiences: [Experience] = []

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }

    func validateGender() -> Bool {
        gender != nil
    }

    func validateLessonRegion() -> Bool {
        lessonRegion != nil
    }
}

extension TeacherSignUpModel {
    func toDomain() -> TeacherCreateData? {
        return TeacherCreateData(
            socialLoginType: socialLoginType,
            name: name,
            major: major,
            gender: gender,
            region: lessonRegion,
            profileImageData: profileImageData,
            experiences: experiences,
        )
    }
}

extension TeacherSignUpModel: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        TeacherSignUpModel(
            socialLoginType: \(socialLoginType),
            name: \(name),
            major: \(String(describing: major)),
            gender: 
        )
        """
    }
}
