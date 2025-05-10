// Created for Umpa in 2025

import Foundation

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
    public let subject: LessonSubject
    public let availableLessonDays: [Weekday]
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
        subject: LessonSubject,
        availableLessonDays: [Weekday],
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
        self.availableLessonDays = availableLessonDays
        self.requirements = requirements
        self.favoriteServices = favoriteServices
    }
}
