// Created for Umpa in 2025

import Components
import Domain
import Factory
import SFSafeSymbols
import SwiftUI

struct LessonFilterSettingView: View {
    @Environment(\.dismiss) private var dismiss

    /// 실제 적용할 필터 정보
    @Bindable var lessonFilter: LessonFilter

    @State private var filterSheetManager: LessonFilterSheetManager

    init(lessonFilter: LessonFilter) {
        self.lessonFilter = lessonFilter
        self._filterSheetManager = State(initialValue: LessonFilterSheetManager(lessonFilter: lessonFilter))
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
                        header
                        filterList
                    }
                    .padding(.horizontal, fs(20))

                    Spacer()
                }

                lessonSubjectChangeSheet
                teacherMajorChangeSheet
            }

            FilterSettingBottomActionView(
                applyButtonTitle: filterSheetManager.isAnyFilterSheetShowing ? "선택 완료" : "필터 설정 완료",
                resetButtonTitle: filterSheetManager.isAnyFilterSheetShowing ? "초기화" : "전체 초기화",
                applyAction: didTapApplyButton,
                resetAction: didTapResetButton,
            )
        }
    }

    var lessonSubjectChangeSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.lessonSubjectFilterBinding,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(30)) {
                sheetHeader(title: "레슨 과목")
                LessonSubjectSelectView(editingSelectedSubjects: $filterSheetManager.editingSubjects)
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    var teacherMajorChangeSheet: some View {
        InstinctSheet(
            isPresenting: filterSheetManager.teacherMajorFilterBinding,
            dismissAction: { filterSheetManager.dismissFilter() }
        ) {
            VStack(spacing: fs(30)) {
                sheetHeader(title: "선생님 전공")
                TeacherMajorSelectView(editingSelectedMajors: $filterSheetManager.editingTeacherMajors)
            }
            .padding(.top, fs(20))
            .padding(.bottom, fs(28))
        }
    }

    var header: some View {
        ZStack(alignment: .trailing) {
            Text("필터 설정")
                .font(.pretendardBold(size: fs(20)))
                .foregroundStyle(UmpaColor.mainBlue)
                .frame(maxWidth: .infinity)
            Button(action: {
                dismiss()
            }) {
                Image(systemSymbol: .xmark)
                    .font(.system(size: fs(20), weight: .medium))
                    .foregroundStyle(.black)
            }
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

    func sheetHeader(title: String) -> some View {
        ZStack(alignment: .trailing) {
            Text(title)
                .font(.pretendardBold(size: fs(20)))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)

            Button(action: {
                filterSheetManager.dismissFilter()
            }) {
                Image(systemSymbol: .xmark)
                    .font(.system(size: fs(20), weight: .medium))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, fs(20))
    }

    // MARK: Private Methods

    private func didTapFilter(_ filter: LessonFilterEntry) {
        filterSheetManager.presentFilter(filter)
    }

    private func didTapApplyButton() {
        if filterSheetManager.isAnyFilterSheetShowing {
            filterSheetManager.applyFilter()
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
    LessonFilterSettingView(lessonFilter: LessonFilter())
}
