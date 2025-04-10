// Created for Umpa in 2025

import Foundation

public struct StudentCreateData {
    public let major: Major
    
    public let name: String
    
    public let username: String
    
    public let dreamCollege: [College]
    
    public let additionalProfileInfo: AdditionalStudentProfileInfo?
}

public struct AdditionalStudentProfileInfo {
    public let profileImage: Data?
    public let grade: Grade
    public let region: Region
    
    public let subject: Subject
    public let availableLessonDay: [WeekDay]
    public let gender: Gender
    
    /// 자기소개 및 요청 사항
    public let requirements: String
    public let favoriteServices: [Service.Id]
}

public struct TeacherCreateData {
    public let major: Major
    
    public let name: String
    
    public let additionalProfileInfo: AdditionalTeacherProfileInfo?
}

public struct AdditionalTeacherProfileInfo {
    public let region: Region
    public let gender: Gender
    public let profileImage: Data?
    
    /// 대표 문구
    public let keyphrase: String
    
    /// 소개글
    public let introduction: String
    
    /// 경력 사항
    public let experiences: [String]
    
    /// 사이트 링크
    public let links: [URL?]
}
