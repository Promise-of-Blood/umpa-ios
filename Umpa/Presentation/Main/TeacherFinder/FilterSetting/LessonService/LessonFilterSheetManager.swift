// Created for Umpa in 2025

import Domain
import SwiftUICore

@Observable
final class LessonFilterSheetManager {
    private let lessonFilter: LessonFilter

    private var presentingState: [LessonFilterEntry: Bool]

    /// 필터 시트에서 과목을 편집하기 위한 상태
    var editingSubjects: Set<LessonSubject> = []

    init(lessonFilter: LessonFilter) {
        self.lessonFilter = lessonFilter
        presentingState = [
            .subject: false,
            .major: false,
            .college: false,
            .region: false,
            .lessonStyle: false,
            .price: false,
            .gender: false,
        ]
        assert(presentingState.count == LessonFilterEntry.allCases.count,
               "모든 필터가 포함되어야 합니다.")
    }

    /// - Warning: 이 프로퍼티의 값을 직접 변경하여 필터 시트를 표시하지 마세요. 예상되지 않은 동작이 발생할 수 있습니다.
    /// 대신 `presentFilter(_:)` 메서드를 사용하세요.
    var lessonSubjectFilterBinding: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.subject]! },
            set: { self.presentingState[.subject] = $0 }
        )
    }

    var isAnyFilterSheetShowing: Bool {
        return presentingState.values.contains { $0 }
    }

    var presentingFilter: LessonFilterEntry? {
        presentingState.first { $0.value }?.key
    }

    func presentFilter(_ filter: LessonFilterEntry) {
        dismissFilter()
        presentingState[filter] = true

        switch filter {
        case .subject:
            resetEditingState()
        case .major:
            break
        case .college:
            break
        case .region:
            break
        case .lessonStyle:
            break
        case .price:
            break
        case .gender:
            break
        }
    }

    func dismissFilter() {
        presentingState.forEach { presentingState[$0.key] = false }
        resetEditingState()
    }

    func applyFilter(_ filterEntry: LessonFilterEntry) {
        switch filterEntry {
        case .subject:
            lessonFilter.lessonSubjects = editingSubjects
            dismissFilter()
        case .major:
            break
        case .college:
            break
        case .region:
            break
        case .lessonStyle:
            break
        case .price:
            break
        case .gender:
            break
        }
    }
    
    private func resetEditingState() {
        editingSubjects = lessonFilter.lessonSubjects ?? []
    }
}
