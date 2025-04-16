// Created for Umpa in 2025

import Foundation

@frozen public enum UserType {
    case student
    case teacher
}

@frozen public enum Gender {
    case male
    case female
}

/// 학년
public enum Grade {
    case 사회인
    case 대학생
    case 재수생
    case high1
    case high2
    case high3
}

public protocol User: Identifiable, Hashable {
    typealias Id = String

    var id: Id { get }
    var userType: UserType { get }
    var major: Major { get }
    var name: String { get }
    var profileImage: URL? { get }
    var region: Region { get }
    var gender: Gender { get }
}

public struct Student: User {
    public let id: Id
    public let userType: UserType
    public let major: Major
    public let name: String
    public let username: String
    public let profileImage: URL?
    public let region: Region
    public let gender: Gender
    public let grade: Grade
    public let dreamCollege: [College]
    public let subject: Subject
    public let availableLessonDay: [WeekDay]
    public let requirements: String // 자기소개 및 요청 사항
    public let favoriteServices: [Service.Id]

    public init(
        id: Id,
        userType: UserType,
        major: Major,
        name: String,
        username: String,
        profileImage: URL?,
        region: Region,
        gender: Gender,
        grade: Grade,
        dreamCollege: [College],
        subject: Subject,
        availableLessonDay: [WeekDay],
        requirements: String,
        favoriteServices: [Service.Id]
    ) {
        self.id = id
        self.userType = userType
        self.major = major
        self.name = name
        self.username = username
        self.profileImage = profileImage
        self.region = region
        self.gender = gender
        self.grade = grade
        self.dreamCollege = dreamCollege
        self.subject = subject
        self.availableLessonDay = availableLessonDay
        self.requirements = requirements
        self.favoriteServices = favoriteServices
    }
}

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
    public let experiences: [String]
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
        experiences: [String],
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
