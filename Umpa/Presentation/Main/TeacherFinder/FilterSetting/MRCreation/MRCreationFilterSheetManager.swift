// Created for Umpa in 2025

import Domain
import SwiftUICore

@Observable
final class MRCreationFilterSheetManager: FilterSheetManager {
    private let filter: MRCreationFilter

    private var presentingState: [MRCreationFilterEntry: Bool]

    // MARK: State

    var editingColleges: [College] = []

    var editingTurnaround: TurnaroundFilter = .all

    var editingMRCreationFee: MRCreationFeeFilter = .all

    init(filter: MRCreationFilter) {
        self.filter = filter
        presentingState = [
            .college: false,
            .turnaround: false,
            .fee: false,
        ]
        assert(presentingState.count == MRCreationFilterEntry.allCases.count,
               "모든 필터가 포함되어야 합니다.")
    }

    // MARK: Bindings

    /// - Warning: 이 프로퍼티의 값을 직접 변경하여 필터 시트를 표시하지 마세요. 예상되지 않은 동작이 발생할 수 있습니다.
    /// 대신 `presentFilter(_:)` 메서드를 사용하세요.
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

    var presentingFilter: MRCreationFilterEntry? {
        presentingState.first { $0.value }?.key
    }

    // MARK: API

    func presentFilter(_ filterEntry: MRCreationFilterEntry) {
        dismissFilter()
        presentingState[filterEntry] = true
        restoreAllEditingState()
    }

    func dismissFilter() {
        presentingState.forEach { presentingState[$0.key] = false }
        restoreAllEditingState()
    }

    func completeFilter(_ filterEntry: MRCreationFilterEntry) {
        switch filterEntry {
        case .college:
            filter.colleges = editingColleges
        case .turnaround:
            filter.turnaround = editingTurnaround
        case .fee:
            filter.fee = editingMRCreationFee
        }
        dismissFilter()
    }

    func resetPresentingFilter(_ filterEntry: MRCreationFilterEntry) {
        switch filterEntry {
        case .college:
            editingColleges = []
        case .turnaround:
            editingTurnaround = .all
        case .fee:
            editingMRCreationFee = .all
        }
    }

    func resetAllFilters() {
        filter.reset()
        restoreAllEditingState()
    }

    // MARK: Private Methods

    private func restoreAllEditingState() {
        for filter in MRCreationFilterEntry.allCases {
            restoreEditingState(of: filter)
        }
    }

    private func restoreEditingState(of filterEntry: MRCreationFilterEntry) {
        switch filterEntry {
        case .college:
            editingColleges = filter.colleges
        case .turnaround:
            editingTurnaround = filter.turnaround
        case .fee:
            editingMRCreationFee = filter.fee
        }
    }
}
