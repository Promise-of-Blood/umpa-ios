// Created for Umpa in 2025

import Domain
import Foundation

@Observable
final class LessonFilter {
    var lessonSubjects: Set<LessonSubject> = []
    var teacherMajors: Set<Major> = []
    var colleges: [College] = []
    var lessonRegions: [Region] = []
    var lessonStyle: LessonStyle = .both
    var lessonFee: LessonFee = .all
    var gender: GenderFilter = .all

    func reset() {
        lessonSubjects = []
        teacherMajors = []
        colleges = []
        lessonRegions = []
        lessonStyle = .both
        lessonFee = .all
        gender = .all
    }
}
