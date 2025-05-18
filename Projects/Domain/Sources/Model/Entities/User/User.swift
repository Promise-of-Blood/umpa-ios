// Created for Umpa in 2025

import Foundation

public enum UserType {
    case student
    case teacher
}

public enum Gender {
    case male
    case female
}

/// 학년
public enum Grade: Int, CaseIterable {
    case 사회인 = 0
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
