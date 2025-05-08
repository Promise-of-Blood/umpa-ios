// Created for Umpa in 2025

import Domain
import SwiftUICore

@Observable
final class AccompanistFilterSheetManager {
    private let accompanistFilter: AccompanistFilter

    private var presentingState: [AccompanistFilterEntry: Bool]

    // MARK: State

    var editingInstruments: Set<InstrumentFilter> = []

    var editingColleges: [College] = []

    var editingRegions: [Region] = []

    var editingAccompanistFee: AccompanistFeeFilter = .all

    var editingGender: GenderFilter = .all

    init(accompanistFilter: AccompanistFilter) {
        self.accompanistFilter = accompanistFilter
        presentingState = [
            .instrument: false,
            .college: false,
            .region: false,
            .accompanistFee: false,
            .gender: false,
        ]
        assert(presentingState.count == AccompanistFilterEntry.allCases.count,
               "모든 필터가 포함되어야 합니다.")
    }

    // MARK: Bindings

    /// - Warning: 이 프로퍼티의 값을 직접 변경하여 필터 시트를 표시하지 마세요. 예상되지 않은 동작이 발생할 수 있습니다.
    /// 대신 `presentFilter(_:)` 메서드를 사용하세요.
    var isShowingInstrumentSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.instrument]! },
            set: { self.presentingState[.instrument] = $0 }
        )
    }

    var isShowingCollegeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.college]! },
            set: { self.presentingState[.college] = $0 }
        )
    }

    var isShowingRegionSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.region]! },
            set: { self.presentingState[.region] = $0 }
        )
    }

    var isShowingAccompanistFeeFeeSelector: Binding<Bool> {
        Binding<Bool>(
            get: { self.presentingState[.accompanistFee]! },
            set: { self.presentingState[.accompanistFee] = $0 }
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

    var presentingFilter: AccompanistFilterEntry? {
        presentingState.first { $0.value }?.key
    }

    // MARK: API

    func presentFilter(_ filter: AccompanistFilterEntry) {
        dismissFilter()
        presentingState[filter] = true
        restoreAllEditingState()
    }

    func dismissFilter() {
        presentingState.forEach { presentingState[$0.key] = false }
        restoreAllEditingState()
    }

    func applyFilter(_ filter: AccompanistFilterEntry) {
        switch filter {
        case .instrument:
            accompanistFilter.instruments = editingInstruments
        case .college:
            accompanistFilter.colleges = editingColleges
        case .region:
            accompanistFilter.regions = editingRegions
        case .accompanistFee:
            accompanistFilter.accompanistFee = editingAccompanistFee
        case .gender:
            accompanistFilter.gender = editingGender
        }
        dismissFilter()
    }

    func resetEditingFilter(_ filter: AccompanistFilterEntry) {
        switch filter {
        case .instrument:
            editingInstruments = []
        case .college:
            editingColleges = []
        case .region:
            editingRegions = []
        case .accompanistFee:
            editingAccompanistFee = .all
        case .gender:
            editingGender = .all
        }
    }

    func resetAllFilters() {
        accompanistFilter.reset()
        restoreAllEditingState()
    }

    // MARK: Private Methods

    private func restoreAllEditingState() {
        for filter in AccompanistFilterEntry.allCases {
            restoreEditingState(of: filter)
        }
    }

    private func restoreEditingState(of filter: AccompanistFilterEntry) {
        switch filter {
        case .instrument:
            editingInstruments = accompanistFilter.instruments
        case .college:
            editingColleges = accompanistFilter.colleges
        case .region:
            editingRegions = accompanistFilter.regions
        case .accompanistFee:
            editingAccompanistFee = accompanistFilter.accompanistFee
        case .gender:
            editingGender = accompanistFilter.gender
        }
    }
}
