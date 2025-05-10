// Created for Umpa in 2025

import Components
import Domain
import Factory
import SFSafeSymbols
import SwiftUI

struct ScoreCreationFilterSettingView: View {
    @Environment(\.dismiss) private var dismiss

    @Injected(\.appState) private var appState

    /// 실제 적용할 필터 정보
    @Bindable var filter: ScoreCreationFilter

    @State private var filterSheetManager: ScoreCreationFilterSheetManager

    init(filter: ScoreCreationFilter) {
        self.filter = filter
        self._filterSheetManager = State(initialValue: ScoreCreationFilterSheetManager(filter: filter))
    }

    // MARK: View

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: 0) {
            ZStack {
                VStack(spacing: 0) {
                    VStack(spacing: FilterSettingConstant.titleHeaderBottomSpacing) {
                        FilterSettingViewHeader(title: "악보제작 필터 설정")
                        filterList
                    }
                    .padding(.horizontal, FilterSettingConstant.filterListHorizontalPadding)

                    Spacer()
                }

                filterSheets
            }

            FilterSettingBottomActionView(
                applyButtonTitle: filterSheetManager.isAnyFilterSheetShowing ?
                    FilterSettingConstant.sheetCompleteButtonText : FilterSettingConstant.completeButtonText,
                resetButtonTitle: filterSheetManager.isAnyFilterSheetShowing ?
                    FilterSettingConstant.sheetResetButtonText : FilterSettingConstant.resetButtonText,
                applyAction: didTapApplyButton,
                resetAction: didTapResetButton,
            )
        }
    }

    var filterList: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(
                    Array(zip(ScoreCreationFilterEntry.allCases.indices, ScoreCreationFilterEntry.allCases)),
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

                    if index < ScoreCreationFilterEntry.allCases.count - 1 {
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
            scoreTypeSelectSheet
            collegeSelectSheet
            turnaroundSelectSheet
            scoreCreationFeeSelectSheet
        }
    }

    var scoreTypeSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingScoreTypeSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: ScoreCreationFilterEntry.scoreType, dismissAction: filterSheetManager.dismissFilter)
                ScoreTypeSelectView(
                    selectedScoreTypes: $filterSheetManager.editingScoreTypes,
                    scoreTypeList: ScoreTypeFilter.allCases
                )
                .padding(.horizontal, fs(20))
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
                FilterSheetHeader(filterEntry: ScoreCreationFilterEntry.college, dismissAction: filterSheetManager.dismissFilter)
                CollegeSelectView(
                    collegeList: appState.appData.collegeList,
                    selectedColleges: $filterSheetManager.editingColleges
                )
            }
            .padding(.top, fs(20))
        }
    }

    var turnaroundSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingTurnaroundSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: ScoreCreationFilterEntry.turnaround, dismissAction: filterSheetManager.dismissFilter)
                TurnaroundSelectView(selectedTurnaround: $filterSheetManager.editingTurnaround)
                    .padding(.horizontal, fs(26))
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    var scoreCreationFeeSelectSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.isShowingFeeSelector,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(24)) {
                FilterSheetHeader(filterEntry: ScoreCreationFilterEntry.fee, dismissAction: filterSheetManager.dismissFilter)
                ScoreCreationFeeSelectView(selectedScoreCreationFee: $filterSheetManager.editingScoreCreationFee)
                    .padding(.horizontal, fs(26))
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    // MARK: Private Methods

    private func didTapFilter(_ filter: ScoreCreationFilterEntry) {
        filterSheetManager.presentFilter(filter)
    }

    private func didTapApplyButton() {
        if let presentingFilter = filterSheetManager.presentingFilter {
            filterSheetManager.completeFilter(presentingFilter)
        } else {
            dismiss()
        }
    }

    private func didTapResetButton() {
        if let presentingFilter = filterSheetManager.presentingFilter {
            filterSheetManager.resetPresentingFilter(presentingFilter)
        } else {
            filterSheetManager.resetAllFilters()
        }
    }
}

#Preview {
    ScoreCreationFilterSettingView(filter: ScoreCreationFilter())
}
