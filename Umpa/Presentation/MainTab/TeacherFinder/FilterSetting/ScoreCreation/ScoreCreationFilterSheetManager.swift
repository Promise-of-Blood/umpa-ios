// Created for Umpa in 2025

import Domain
import SwiftUI

@Observable
final class ScoreCreationFilterSheetManager: FilterSheetManager {
    private let filter: ScoreCreationFilter

    private var presentingState: [ScoreCreationFilterEntry: Bool]

    // MARK: State

    var editingScoreTypes: Set<ScoreTypeFilter> = []

    var editingColleges: [College] = []

    var editingTurnaround: TurnaroundFilter = .all

    var editingScoreCreationFee: ScoreCreationFeeFilter = .all

    init(filter: ScoreCreationFilter) {
        self.filter = filter
        presentingState = [
            .scoreType: false,
            .college: false,
            .turnaround: false,
            .fee: false,
        ]
        assert(presentingState.count == ScoreCreationFilterEntry.allCases.count,
               "모든 필터가 포함되어야 합니다.")
    }

    // MARK: Bindings

    /// - Warning: 이 프로퍼티의 값을 직접 변경하여 필터 시트를 표시하지 마세요. 예상되지 않은 동작이 발생할 수 있습니다.
    /// 대신 `presentFilter(_:)` 메서드를 사용하세요.
    var isShowingScoreTypeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.scoreType] ?? false },
            set: { self.presentingState[.scoreType] = $0 }
        )
    }

    var isShowingCollegeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.college] ?? false },
            set: { self.presentingState[.college] = $0 }
        )
    }

    var isShowingTurnaroundSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.turnaround] ?? false },
            set: { self.presentingState[.turnaround] = $0 }
        )
    }

    var isShowingFeeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.fee] ?? false },
            set: { self.presentingState[.fee] = $0 }
        )
    }

    var isAnyFilterSheetShowing: Bool {
        return presentingState.values.contains { $0 }
    }

    var presentingFilter: ScoreCreationFilterEntry? {
        presentingState.first { $0.value }?.key
    }

    // MARK: API

    func presentFilter(_ filterEntry: ScoreCreationFilterEntry) {
        dismissFilter()
        presentingState[filterEntry] = true
        restoreAllEditingState()
    }

    func dismissFilter() {
        presentingState.forEach { presentingState[$0.key] = false }
        restoreAllEditingState()
    }

    func completeFilter(_ filterEntry: ScoreCreationFilterEntry) {
        switch filterEntry {
        case .scoreType:
            filter.scoreTypes = editingScoreTypes
        case .college:
            filter.colleges = editingColleges
        case .turnaround:
            filter.turnaround = editingTurnaround
        case .fee:
            filter.fee = editingScoreCreationFee
        }
        dismissFilter()
    }

    func resetPresentingFilter(_ filterEntry: ScoreCreationFilterEntry) {
        switch filterEntry {
        case .scoreType:
            editingScoreTypes = []
        case .college:
            editingColleges = []
        case .turnaround:
            editingTurnaround = .all
        case .fee:
            editingScoreCreationFee = .all
        }
    }

    func resetAllFilters() {
        filter.reset()
        restoreAllEditingState()
    }

    // MARK: Private Methods

    private func restoreAllEditingState() {
        for filter in ScoreCreationFilterEntry.allCases {
            restoreEditingState(of: filter)
        }
    }

    private func restoreEditingState(of filterEntry: ScoreCreationFilterEntry) {
        switch filterEntry {
        case .scoreType:
            editingScoreTypes = filter.scoreTypes
        case .college:
            editingColleges = filter.colleges
        case .turnaround:
            editingTurnaround = filter.turnaround
        case .fee:
            editingScoreCreationFee = filter.fee
        }
    }
}
