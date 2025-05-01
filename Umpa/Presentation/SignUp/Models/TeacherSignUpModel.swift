// Created for Umpa in 2025

import Combine
import Core
import Domain

final class TeacherSignUpModel: ObservableObject, MajorSelectableModel {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var major: Major?
    @Published var gender: Gender?
    @Published var lessonRegion: Region?
    @Published var profileImageData: Data?
    @Published var experiences: [ExperienceModel] = []
    @Published var siteLinks: [SiteLinkModel] = []

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
        var experiencesDomain: [Experience] = []
        for experience in experiences {
            guard let domain = experience.toDomain() else { return nil }
            experiencesDomain.append(domain)
        }

        let links = siteLinks
            .filter(\.link.isNotEmpty)
            .map { $0.toDomain() }

        return TeacherCreateData(
            socialLoginType: socialLoginType,
            name: name,
            major: major,
            gender: gender,
            region: lessonRegion,
            profileImageData: profileImageData,
            experiences: experiencesDomain,
            links: links,
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
            gender: \(String(describing: gender)),
            lessonRegion: \(String(describing: lessonRegion)),
            profileImageData: \(String(describing: profileImageData)),
            experiences: \(experiences),
            siteLinks: \(siteLinks),
        )
        """
    }
}
