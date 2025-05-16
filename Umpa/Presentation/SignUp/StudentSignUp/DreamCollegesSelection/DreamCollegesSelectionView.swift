// Created for Umpa in 2025

import Core
import Domain
import Factory
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct DreamCollegesSelectionView: View {
  @ObservedObject var signUpModel: StudentSignUpModel
  @Binding var isSatisfiedCurrentInput: Bool

  @State private var isSearchSheetShowing: Bool = false

  /// 현재 검색 중인 희망 학교 인덱스
  @State private var currentSearchingCollege: Int?

  // MARK: View

  var body: some View {
    content
      .sheet(isPresented: $isSearchSheetShowing, onDismiss: {
        currentSearchingCollege = nil
      }) {
        CollegeSearchView(action: setDreamCollege)
          .presentationDetents([.large])
          .presentationDragIndicator(.hidden)
      }
      .onChange(of: [
        signUpModel.dreamCollege0,
        signUpModel.dreamCollege1,
        signUpModel.dreamCollege2,
      ]) {
        isSatisfiedCurrentInput = signUpModel.validateDreamColleges()
      }
  }

  var content: some View {
    VStack(spacing: fs(56)) {
      Text("희망 학교를 설정해주세요")
        .font(SignUpConstant.titleFont)
        .foregroundStyle(SignUpConstant.titleColor)
        .frame(maxWidth: .infinity, alignment: .leading)

      VStack(spacing: fs(34)) {
        DreamCollegesSelectionGroup(
          title: "희망 학교1",
          selectedCollege: signUpModel.dreamCollege0,
          action: {
            didTapSelectDreamCollege(0)
          }
        )
        DreamCollegesSelectionGroup(
          title: "희망 학교2",
          selectedCollege: signUpModel.dreamCollege1,
          action: {
            didTapSelectDreamCollege(1)
          }
        )
        DreamCollegesSelectionGroup(
          title: "희망 학교3",
          selectedCollege: signUpModel.dreamCollege2,
          action: {
            didTapSelectDreamCollege(2)
          }
        )
      }
    }
  }

  // MARK: Private Methods

  private func didTapSelectDreamCollege(_ index: Int) {
    currentSearchingCollege = index
    isSearchSheetShowing = true
  }

  private func setDreamCollege(_ college: College) {
    switch currentSearchingCollege {
    case 0: signUpModel.dreamCollege0 = college
    case 1: signUpModel.dreamCollege1 = college
    case 2: signUpModel.dreamCollege2 = college
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
  let selectedCollege: College?
  let action: () -> Void

  var body: some View {
    VStack(spacing: fs(8)) {
      Text(title)
        .font(.pretendardMedium(size: fs(16)))
        .foregroundStyle(UmpaColor.mainBlue)
        .frame(maxWidth: .infinity, alignment: .leading)

      Button(action: action) {
        HStack {
          Text(selectedCollege?.name ?? "학교 선택")
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

  let action: (College) -> Void

  private var searchResult: [College] {
    appState.appData.collegeList
      .filter { $0.name.contains(searchQuery) }
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
    .background(.white)
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
      .foregroundStyle(.black)
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
          Text(college.name)
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(Color(hex: "9E9E9E"))
        }
        .listRowInsets(EdgeInsets())
      }
    }
    .background(.white)
    .listStyle(.plain)
    .padding(.horizontal, fs(28))
  }

  private func didTapCollege(_ college: College) {
    UmpaLogger(category: .signUp).log("\(college) 선택됨", level: .debug)
    action(college)
    dismiss()
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  DreamCollegesSelectionView(
    signUpModel: StudentSignUpModel(socialLoginType: .apple),
    isSatisfiedCurrentInput: .constant(false)
  )
}
