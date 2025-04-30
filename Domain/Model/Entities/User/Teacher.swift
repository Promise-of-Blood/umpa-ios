// Created for Umpa in 2025

import Foundation

public struct Teacher: User {
    public let id: Id
    public let userType: UserType
    public let major: Major
    public let name: String
    public let profileImage: URL?
    public let region: Region
    public let gender: Gender
    public let isEvaluated: Bool
    /// 대표 문구
    public let keyphrase: String
    /// 소개글
    public let introduction: String
    /// 경력 사항
    public let experiences: [Experience]
    /// 사이트 링크
    public let links: [URL?]
    public let myServices: [Service.Id]

    public init(
        id: Id,
        userType: UserType,
        major: Major,
        name: String,
        profileImage: URL?,
        region: Region,
        gender: Gender,
        isEvaluated: Bool,
        keyphrase: String,
        introduction: String,
        experiences: [Experience],
        links: [URL?],
        myServices: [Service.Id]
    ) {
        self.id = id
        self.userType = userType
        self.major = major
        self.name = name
        self.profileImage = profileImage
        self.region = region
        self.gender = gender
        self.isEvaluated = isEvaluated
        self.keyphrase = keyphrase
        self.introduction = introduction
        self.experiences = experiences
        self.links = links
        self.myServices = myServices
    }
}
