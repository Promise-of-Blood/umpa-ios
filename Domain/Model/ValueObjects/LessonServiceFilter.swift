// Created for Umpa in 2025

import Foundation

public struct LessonServiceFilter {
    public var lessonSubjects: Set<LessonSubject>?
    public var teacherMajors: Set<Major>?
    public var colleges: Set<College>?
    public var lessonRegions: Set<Region>?
    public var lessonStyle: LessonStyle
    public var price: LessonServicePriceFilter
    public var gender: Gender?

    public init(
        lessonSubjects: Set<LessonSubject>? = nil,
        teacherMajors: Set<Major>? = nil,
        colleges: Set<College>? = nil,
        lessonRegions: Set<Region>? = nil,
        lessonStyle: LessonStyle = .both,
        price: LessonServicePriceFilter = .all,
        gender: Gender? = nil
    ) {
        self.lessonSubjects = lessonSubjects
        self.teacherMajors = teacherMajors
        self.colleges = colleges
        self.lessonRegions = lessonRegions
        self.lessonStyle = lessonStyle
        self.price = price
        self.colleges = colleges
        self.gender = gender
    }
}

public enum LessonServicePriceFilter {
    case all
    case lessThanOrEqual200000krwPerHour
    case lessThanOrEqual150000krwPerHour
    case lessThanOrEqual120000krwPerHour
    case lessThanOrEqual100000krwPerHour
    case lessThanOrEqual80000krwPerHour
    case lessThanOrEqual60000krwPerHour
}
