// Created for Umpa in 2025

import Core
import Factory
import SFSafeSymbols
import SwiftUI

struct DreamCollegesSelectionView: View {
    @ObservedObject var studentSignUpModel: StudentSignUpModel
    @Binding var isSatisfiedToNextStep: Bool

    @State private var isSearchSheetShowing: Bool = false

    /// 현재 검색 중인 희망 학교 인덱스
    @State private var currentSearchingCollege: Int?

    // MARK: View

    var body: some View {
        content
            .onAppear {
                isSatisfiedToNextStep = studentSignUpModel.validateDreamColleges()
            }
            .sheet(isPresented: $isSearchSheetShowing) {
                CollegeSearchView(action: setDreamCollege)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.hidden)
            }
            .onChange(of: [
                studentSignUpModel.dreamCollege0,
                studentSignUpModel.dreamCollege1,
                studentSignUpModel.dreamCollege2,
            ]) {
                isSatisfiedToNextStep = studentSignUpModel.validateDreamColleges()
            }
    }

    var content: some View {
        VStack(spacing: fs(56)) {
            Text("희망 학교를 설정해주세요")
                .font(SignUpSharedUIConstant.titleFont)
                .foregroundStyle(SignUpSharedUIConstant.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: fs(34)) {
                DreamCollegesSelectionGroup(
                    title: "희망 학교1",
                    selectedCollege: studentSignUpModel.dreamCollege0,
                    action: didTapSelectdreamCollege0
                )
                DreamCollegesSelectionGroup(
                    title: "희망 학교2",
                    selectedCollege: studentSignUpModel.dreamCollege1,
                    action: didTapSelectdreamCollege1
                )
                DreamCollegesSelectionGroup(
                    title: "희망 학교3",
                    selectedCollege: studentSignUpModel.dreamCollege2,
                    action: didTapSelectdreamCollege2
                )
            }
        }
        .padding(.horizontal, SignUpSharedUIConstant.contentHorizontalPadding)
    }

    // MARK: Private Methods

    private func didTapSelectdreamCollege0() {
        currentSearchingCollege = 0
        isSearchSheetShowing = true
    }

    private func didTapSelectdreamCollege1() {
        currentSearchingCollege = 1
        isSearchSheetShowing = true
    }

    private func didTapSelectdreamCollege2() {
        currentSearchingCollege = 2
        isSearchSheetShowing = true
    }

    private func setDreamCollege(_ college: String) {
        switch currentSearchingCollege {
        case 0: studentSignUpModel.dreamCollege0 = college
        case 1: studentSignUpModel.dreamCollege1 = college
        case 2: studentSignUpModel.dreamCollege2 = college
        default:
            UmpaLogger(category: .signUp).log(
                "`currentSearchingCollege`가 nil입니다.",
                level: .error
            )
            assertionFailure("`currentSearchingCollege`가 nil입니다.")
        }
    }
}

private struct DreamCollegesSelectionGroup: View {
    let title: String
    let selectedCollege: String?
    let action: () -> Void

    var body: some View {
        VStack(spacing: fs(8)) {
            Text(title)
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(UmpaColor.mainBlue)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: action) {
                HStack {
                    Text(selectedCollege ?? "학교 선택")
                        .font(.pretendardMedium(size: fs(16)))
                    Spacer()
                    Image(systemSymbol: .chevronDown)
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(fs(16))
                .foregroundStyle(selectedCollege == nil ? Color(hex: "9E9E9E") : UmpaColor.darkGray)
                .background(.white)
                .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
                .clipShape(RoundedRectangle(cornerRadius: fs(15)))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct CollegeSearchView: View {
    @Environment(\.dismiss) private var dismiss

    @Injected(\.appState) private var appState

    @State private var searchQuery: String = ""

    @FocusState private var isSearchFieldFocused: Bool

    let action: (String) -> Void

    private var searchResult: [String] {
        appState.userData.collegeList.filter { $0.contains(searchQuery) }
    }

    // MARK: View

    var body: some View {
        content
            .onAppear {
                isSearchFieldFocused = true
            }
    }

    var content: some View {
        VStack(spacing: fs(8)) {
            searchHeader
            searchResultView
        }
    }

    var searchHeader: some View {
        HStack(spacing: fs(8)) {
            Image(systemSymbol: .magnifyingglass)
                .foregroundStyle(.gray)
            TextField(
                text: $searchQuery,
                prompt: Text("학교 검색"),
                label: { Text("학교 검색") }
            )
            .focused($isSearchFieldFocused)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, fs(24))
        .padding(.vertical, fs(18))
    }

    var searchResultView: some View {
        List {
            IndexingForEach(searchResult) { _, college in
                Button {
                    didTapCollege(college)
                } label: {
                    Text(college)
                        .font(.pretendardMedium(size: fs(13)))
                        .foregroundStyle(Color(hex: "9E9E9E"))
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, fs(28))
    }

    private func didTapCollege(_ college: String) {
        UmpaLogger(category: .signUp).log("\(college) 선택됨", level: .debug)
        action(college)
        dismiss()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DreamCollegesSelectionView(
        studentSignUpModel: StudentSignUpModel(socialLoginType: .apple),
        isSatisfiedToNextStep: .constant(false)
    )
}
