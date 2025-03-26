// Created for Umpa in 2025

import Foundation

enum UserType {
    case student
    case teacher
}

enum Gender {
    case male
    case female
}

enum Grade {
    case 사회인
    case 대학생
    case 재수생
    // TODO: 기획 정해서 수정
}

protocol User: Identifiable {
    typealias Id = String

    var id: Id { get }
    var userType: UserType { get }
    var major: Major { get }
    var name: String { get }
    var username: String { get }
    var profileImage: URL { get }
    var region: Region { get }
    var gender: Gender { get }
}

struct Student: User {
    let id: Id
    let userType: UserType
    let major: Major
    let name: String
    let username: String
    let profileImage: URL
    let region: Region
    let gender: Gender
    let grade: Grade
    let dreamSchool: [String]
    let subject: Subject
    let availableLessonDay: [WeekDay]
    let requirements: String // 자기소개 및 요청 사항
    let interestingServices: ServiceId
}

struct Teacher: User {
    let id: Id
    let userType: UserType
    let major: Major
    let name: String
    let username: String
    let profileImage: URL
    let region: Region
    let gender: Gender
    let isEvaluated: Bool
    let keyphrase: String
    let introduction: String
    let experiences: [String]
    let links: [URL]
    let myServices: [ServiceId]
}
