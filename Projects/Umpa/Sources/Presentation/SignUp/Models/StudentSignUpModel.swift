// Created for Umpa in 2025

import Combine
import Domain
import Foundation

final class StudentSignUpModel: ObservableObject, MajorSelectableModel {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var major: Major?
    @Published var dreamCollege0: College?
    @Published var dreamCollege1: College?
    @Published var dreamCollege2: College?
    @Published var profileImageData: Data?
    @Published var grade: Grade?
    @Published var gender: Gender?
    @Published var preferSubject: Domain.LessonSubject?
    @Published var lessonStyle: LessonStyle?
    @Published var availableLessonDays: [Domain.Weekday] = []
    @Published var lessonRequirements: String = ""

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
            dreamCollege0: dreamCollege0,
            dreamCollege1: dreamCollege1,
            dreamCollege2: dreamCollege2,
            profileImageData: profileImageData,
            grade: grade,
            gender: gender,
            preferSubject: preferSubject,
            lessonStyle: lessonStyle,
            availableLessonDays: availableLessonDays,
            lessonRequirements: lessonRequirements
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
            dreamCollege2: \(String(describing: dreamCollege2)),
            profileImageData: \(String(describing: profileImageData)),
            grade: \(String(describing: grade)),
            gender: \(String(describing: gender)),
            preferSubject: \(String(describing: preferSubject)),
            lessonStyle: \(String(describing: lessonStyle)),
            availableLessonDays: \(availableLessonDays),
            lessonRequirements: \(lessonRequirements),
        )
        """
    }
}
