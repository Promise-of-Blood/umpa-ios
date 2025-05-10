// Created for Umpa in 2025

import Domain
import SwiftUICore

@Observable
final class LessonFilterSheetManager: FilterSheetManager {
    private let lessonFilter: LessonFilter

    private var presentingState: [LessonFilterEntry: Bool]

    // MARK: State

    /// 필터 시트에서 과목을 편집하기 위한 상태
    var editingSubjects: Set<LessonSubject> = []

    var editingTeacherMajors: Set<Major> = []

    var editingColleges: [College] = []

    var editingLessonRegions: [Region] = []

    var editingLessonStyles: LessonStyle = .both

    var editingLessonFee: LessonFee = .all

    var editingGender: GenderFilter = .all

    init(lessonFilter: LessonFilter) {
        self.lessonFilter = lessonFilter
        presentingState = [
            .subject: false,
            .major: false,
            .college: false,
            .region: false,
            .lessonStyle: false,
            .fee: false,
            .gender: false,
        ]
        assert(presentingState.count == LessonFilterEntry.allCases.count,
               "모든 필터가 포함되어야 합니다.")
    }

    // MARK: Bindings

    /// - Warning: 이 프로퍼티의 값을 직접 변경하여 필터 시트를 표시하지 마세요. 예상되지 않은 동작이 발생할 수 있습니다.
    /// 대신 `presentFilter(_:)` 메서드를 사용하세요.
    var isShowingLessonSubjectSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.subject]! },
            set: { self.presentingState[.subject] = $0 }
        )
    }

    var isShowingTeacherMajorSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.major]! },
            set: { self.presentingState[.major] = $0 }
        )
    }

    var isShowingCollegeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.college]! },
            set: { self.presentingState[.college] = $0 }
        )
    }

    var isShowingLessonRegionSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.region]! },
            set: { self.presentingState[.region] = $0 }
        )
    }

    var isShowingLessonStyleSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.lessonStyle]! },
            set: { self.presentingState[.lessonStyle] = $0 }
        )
    }

    var isShowingLessonFeeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.fee]! },
            set: { self.presentingState[.fee] = $0 }
        )
    }

    var isShowingGenderSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.gender]! },
            set: { self.presentingState[.gender] = $0 }
        )
    }

    var isAnyFilterSheetShowing: Bool {
        return presentingState.values.contains { $0 }
    }

    var presentingFilter: LessonFilterEntry? {
        presentingState.first { $0.value }?.key
    }

    // MARK: API

    func presentFilter(_ filter: LessonFilterEntry) {
        dismissFilter()
        presentingState[filter] = true
        restoreAllEditingState()
    }

    func dismissFilter() {
        presentingState.forEach { presentingState[$0.key] = false }
        restoreAllEditingState()
    }

    func completeFilter(_ filter: LessonFilterEntry) {
        switch filter {
        case .subject:
            lessonFilter.lessonSubjects = editingSubjects
        case .major:
            lessonFilter.teacherMajors = editingTeacherMajors
        case .college:
            lessonFilter.colleges = editingColleges
        case .region:
            lessonFilter.lessonRegions = editingLessonRegions
        case .lessonStyle:
            lessonFilter.lessonStyle = editingLessonStyles
        case .fee:
            lessonFilter.lessonFee = editingLessonFee
        case .gender:
            lessonFilter.gender = editingGender
        }
        dismissFilter()
    }

    func resetPresentingFilter(_ filter: LessonFilterEntry) {
        switch filter {
        case .subject:
            editingSubjects = []
        case .major:
            editingTeacherMajors = []
        case .college:
            editingColleges = []
        case .region:
            editingLessonRegions = []
        case .lessonStyle:
            editingLessonStyles = .both
        case .fee:
            editingLessonFee = .all
        case .gender:
            editingGender = .all
        }
    }

    func resetAllFilters() {
        lessonFilter.reset()
        restoreAllEditingState()
    }

    // MARK: Private Methods

    private func restoreAllEditingState() {
        for filter in LessonFilterEntry.allCases {
            restoreEditingState(of: filter)
        }
    }

    private func restoreEditingState(of filter: LessonFilterEntry) {
        switch filter {
        case .subject:
            editingSubjects = lessonFilter.lessonSubjects
        case .major:
            editingTeacherMajors = lessonFilter.teacherMajors
        case .college:
            editingColleges = lessonFilter.colleges
        case .region:
            editingLessonRegions = lessonFilter.lessonRegions
        case .lessonStyle:
            editingLessonStyles = lessonFilter.lessonStyle
        case .fee:
            editingLessonFee = lessonFilter.lessonFee
        case .gender:
            editingGender = lessonFilter.gender
        }
    }
}
