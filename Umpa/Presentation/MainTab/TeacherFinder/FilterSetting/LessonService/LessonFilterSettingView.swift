// Created for Umpa in 2025

import Domain
import Factory
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct LessonFilterSettingView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.appState) private var appState

  /// 실제 적용할 필터 정보
  @Bindable var lessonFilter: LessonFilter

  @State private var filterSheetManager: LessonFilterSheetManager

  init(lessonFilter: LessonFilter) {
    self.lessonFilter = lessonFilter
    _filterSheetManager = State(initialValue: LessonFilterSheetManager(lessonFilter: lessonFilter))
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
            FilterSettingViewHeader(title: "레슨 필터 설정")
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
          Array(zip(LessonFilterEntry.allCases.indices, LessonFilterEntry.allCases)),
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

          if index < LessonFilterEntry.allCases.count - 1 {
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
      lessonSubjectSelectSheet
      teacherMajorSelectSheet
      collegeSelectSheet
      lessonRegionSelectSheet
      lessonStyleSelectSheet
      lessonFeeSelectSheet
      genderSelectSheet
    }
  }

  var lessonSubjectSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingLessonSubjectSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(30)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.subject, dismissAction: filterSheetManager.dismissFilter)
        LessonSubjectSelectView(editingSelectedSubjects: $filterSheetManager.editingSubjects)
          .padding(.horizontal, fs(20))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  var teacherMajorSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingTeacherMajorSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(30)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.major, dismissAction: filterSheetManager.dismissFilter)
        TeacherMajorSelectView(editingSelectedMajors: $filterSheetManager.editingTeacherMajors)
          .padding(.horizontal, fs(20))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  var collegeSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingCollegeSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.college, dismissAction: filterSheetManager.dismissFilter)
        CollegeSelectView(
          collegeList: appState.appData.collegeList,
          selectedColleges: $filterSheetManager.editingColleges
        )
      }
      .padding(.top, fs(20))
    }
  }

  var lessonRegionSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingLessonRegionSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.region, dismissAction: filterSheetManager.dismissFilter)
        RegionSelectView(selectedRegions: $filterSheetManager.editingLessonRegions)
      }
      .padding(.top, fs(20))
    }
  }

  var lessonStyleSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingLessonStyleSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(28)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.lessonStyle, dismissAction: filterSheetManager.dismissFilter)
        LessonStyleSelectView(selectedLessonStyle: $filterSheetManager.editingLessonStyles)
          .padding(.horizontal, fs(26))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  var lessonFeeSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingLessonFeeSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.fee, dismissAction: filterSheetManager.dismissFilter)
        LessonFeeSelectView(selectedLessonFee: $filterSheetManager.editingLessonFee)
          .padding(.horizontal, fs(26))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  var genderSelectSheet: some View {
    InstinctHeightSheet(
      isPresenting: filterSheetManager.isShowingGenderSelector,
      dismissAction: { filterSheetManager.dismissFilter() }
    ) {
      VStack(spacing: fs(24)) {
        FilterSheetHeader(filterEntry: LessonFilterEntry.gender, dismissAction: filterSheetManager.dismissFilter)
        GenderSelectView(selectedGender: $filterSheetManager.editingGender)
          .padding(.horizontal, fs(26))
      }
      .padding(.top, fs(20))
      .padding(.bottom, fs(28))
    }
  }

  // MARK: Private Methods

  private func didTapFilter(_ filter: LessonFilterEntry) {
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
  LessonFilterSettingView(lessonFilter: LessonFilter())
}
