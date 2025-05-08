// Created for Umpa in 2025

import Components
import Domain
import Factory
import SFSafeSymbols
import SwiftUI

struct AccompanistFilterSettingView: View {
    @Environment(\.dismiss) private var dismiss

    @Injected(\.appState) private var appState

    /// 실제 적용할 필터 정보
    @Bindable var accompanistFilter: AccompanistFilter

    @State private var filterSheetManager: AccompanistFilterSheetManager

    init(accompanistFilter: AccompanistFilter) {
        self.accompanistFilter = accompanistFilter
        self._filterSheetManager = State(initialValue: AccompanistFilterSheetManager(accompanistFilter: accompanistFilter))
    }

    // MARK: View

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: 0) {
            ZStack {
                VStack(spacing: 0) {
                    VStack(spacing: fs(40)) {
                        FilterSettingViewHeader(title: "입시반주 필터 설정")
                        filterList
                    }
                    .padding(.horizontal, fs(20))

                    Spacer()
                }

                filterSheets
            }

            FilterSettingBottomActionView(
                applyButtonTitle: filterSheetManager.isAnyFilterSheetShowing ? "선택 완료" : "필터 설정 완료",
                resetButtonTitle: filterSheetManager.isAnyFilterSheetShowing ? "초기화" : "전체 초기화",
                applyAction: didTapApplyButton,
                resetAction: didTapResetButton,
            )
        }
    }

    var filterList: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(
                    Array(zip(AccompanistFilterEntry.allCases.indices, AccompanistFilterEntry.allCases)),
                    id: \.1.id
                ) { index, filter in
                    Button(action: {
                        withAnimation {
                            didTapFilter(filter)
                        }
                    }) {
                        HStack {
                            Text(filter.name)
                                .font(.pretendardBold(size: fs(18)))
                                .foregroundStyle(.black)

                            Spacer()

                            HStack(spacing: fs(5)) {
                                Text("전체")
                                    .font(.pretendardMedium(size: fs(16)))
                                Image(systemSymbol: .chevronRight)
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .foregroundStyle(UmpaColor.mainBlue)
                        }
                        .padding(.vertical, fs(24))
                    }

                    if index < AccompanistFilterEntry.allCases.count - 1 {
                        HorizontalDivider(color: UmpaColor.baseColor)
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: .vertical)
    }

    // MARK: Filter Sheets

    var filterSheets: some View {
        Group {
            instrumentSelectSheet
            collegeSelectSheet
            regionSelectSheet
            accompanistFeeSelectSheet
            genderSelectSheet
        }
    }

    var instrumentSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingInstrumentSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: AccompanistFilterEntry.instrument, dismissAction: filterSheetManager.dismissFilter)
                InstrumentSelectView(
                    selectedInstruments: $filterSheetManager.editingInstruments,
                    instrumentList: appState.appData.accompanimentInstrumentList.map(\.name)
                )
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    var collegeSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingCollegeSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: AccompanistFilterEntry.college, dismissAction: filterSheetManager.dismissFilter)
                CollegeSelectView(
                    collegeList: appState.appData.collegeList,
                    selectedColleges: $filterSheetManager.editingColleges
                )
            }
            .padding(.top, fs(20))
        }
    }

    var regionSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingRegionSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: AccompanistFilterEntry.region, dismissAction: filterSheetManager.dismissFilter)
                RegionSelectView(selectedRegions: $filterSheetManager.editingRegions)
            }
            .padding(.top, fs(20))
        }
    }

    var accompanistFeeSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingAccompanistFeeFeeSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: AccompanistFilterEntry.accompanistFee, dismissAction: filterSheetManager.dismissFilter)
                AccompanistFeeSelectView(selectedAccompanistFee: $filterSheetManager.editingAccompanistFee)
                    .padding(.horizontal, fs(26))
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    var genderSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingGenderSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: AccompanistFilterEntry.gender, dismissAction: filterSheetManager.dismissFilter)
                GenderSelectView(selectedGender: $filterSheetManager.editingGender)
                    .padding(.horizontal, fs(26))
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    // MARK: Private Methods

    private func didTapFilter(_ filter: AccompanistFilterEntry) {
        filterSheetManager.presentFilter(filter)
    }

    private func didTapApplyButton() {
        if let presentingFilter = filterSheetManager.presentingFilter {
            filterSheetManager.applyFilter(presentingFilter)
        } else {
            dismiss()
        }
    }

    private func didTapResetButton() {
        if let presentingFilter = filterSheetManager.presentingFilter {
            filterSheetManager.resetEditingFilter(presentingFilter)
        } else {
            filterSheetManager.resetAllFilters()
        }
    }
}

#Preview {
    AccompanistFilterSettingView(accompanistFilter: AccompanistFilter())
}
