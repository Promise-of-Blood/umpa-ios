// Created for Umpa in 2025

import Domain
import Foundation

@Observable
final class LessonFilter {
    var lessonSubjects: Set<LessonSubject>?
    var teacherMajors: Set<Major>?
    var colleges: [College]?
    var lessonRegions: Set<Region>?
    var lessonStyle: LessonStyle = .both
    var price: LessonServicePriceFilter = .all
    var gender: GenderFilter?

    func reset() {
        lessonSubjects = nil
        teacherMajors = nil
        colleges = nil
        lessonRegions = nil
        lessonStyle = .both
        price = .all
        gender = nil
    }
}
