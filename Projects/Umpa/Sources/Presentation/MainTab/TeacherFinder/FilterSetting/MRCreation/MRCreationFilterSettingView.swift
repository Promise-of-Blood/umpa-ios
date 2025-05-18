// Created for Umpa in 2025

import BaseFeature
import Domain
import Factory
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct MRCreationFilterSettingView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(AppState.self) private var appState

  /// 실제 적용할 필터 정보
  @Bindable var filter: MRCreationFilter

  @State private var filterSheetManager: MRCreationFilterSheetManager

  init(filter: MRCreationFilter) {
    self.filter = filter
    _filterSheetManager = State(initialValue: MRCreationFilterSheetManager(filter: filter))
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
            FilterSettingViewHeader(title: "MR제작 필터 설정")
            filterList
          }
          .padding(.horizontal, FilterSettingConstant.filterListHorizontalPadding)

          Spacer()
        }

        filterSheets
      }

      FilterSettingBottomActionView(
        applyButtonTitle: filterSheetManager.isAnyFilterSheetShowing
          ? FilterSettingConstant.sheetCompleteButtonText
          : FilterSettingConstant.completeButtonText,
        resetButtonTitle: filterSheetManager.isAnyFilterSheetShowing
          ? FilterSettingConstant.sheetResetButtonText
          : FilterSettingConstant.resetButtonText,
        applyAction: didTapApplyButton,
        resetAction: didTapResetButton,
      )
    }
  }

  var filterList: some View {
    ScrollView(.vertical) {
      VStack(spacing: 0) {
        ForEach(
          Array(zip(MRCreationFilterEntry.allCases.indices, MRCreationFilterEntry.allCases)),
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

          if index < MRCreationFilterEntry.allCases.count - 1 {
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
      collegeSelectSheet
      turnaroundSelectSheet
      mrCreationFeeSelectSheet
    }
  }

  var collegeSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingCollegeSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: MRCreationFilterEntry.college, dismissAction: filterSheetManager.dismissFilter)
        CollegeSelectView(
          collegeList: appState.appData.collegeList,
          selectedColleges: $filterSheetManager.editingColleges
        )
      }
      .padding(.top, fs(20))
    }
  }

  var turnaroundSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingTurnaroundSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: MRCreationFilterEntry.turnaround, dismissAction: filterSheetManager.dismissFilter)
        TurnaroundSelectView(selectedTurnaround: $filterSheetManager.editingTurnaround)
          .padding(.horizontal, fs(26))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  var mrCreationFeeSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingFeeSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: MRCreationFilterEntry.fee, dismissAction: filterSheetManager.dismissFilter)
        MRCreationFeeSelectView(selectedMRCreationFee: $filterSheetManager.editingMRCreationFee)
          .padding(.horizontal, fs(26))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  // MARK: Private Methods

  private func didTapFilter(_ filter: MRCreationFilterEntry) {
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
  MRCreationFilterSettingView(filter: MRCreationFilter())
}
