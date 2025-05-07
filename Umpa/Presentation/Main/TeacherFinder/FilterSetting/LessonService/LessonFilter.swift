// Created for Umpa in 2025

import Domain
import Foundation

@Observable
final class LessonFilter {
    var lessonSubjects: Set<LessonSubject>?
    var teacherMajors: Set<Major>?
    var colleges: Set<College>?
    var lessonRegions: Set<Region>?
    var lessonStyle: LessonStyle = .both
    var price: LessonServicePriceFilter = .전체
    var gender: Gender?
}
