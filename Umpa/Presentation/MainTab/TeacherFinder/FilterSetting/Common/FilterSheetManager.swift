// Created for Umpa in 2025

import Foundation

protocol FilterSheetManager {
    associatedtype SomeFilterEntry: FilterEntry

    var isAnyFilterSheetShowing: Bool { get }

    /// 현재 표시중인 필터 시트 종류.
    var presentingFilter: SomeFilterEntry? { get }

    /// 필터 시트를 표시합니다.
    func presentFilter(_ filter: SomeFilterEntry)

    /// 저장하지 않고 필터 시트를 닫습니다.
    func dismissFilter()

    /// 필터를 저장하고 필터 시트를 닫습니다.
    func completeFilter(_ filter: SomeFilterEntry)

    /// 현재 표시중인 필터를 초기화합니다.
    func resetPresentingFilter(_ filter: SomeFilterEntry)

    /// 모든 필터를 초기화합니다.
    func resetAllFilters()
}
