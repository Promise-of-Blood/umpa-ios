// Created for Umpa in 2025

import Core
import Domain
import Factory
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct CollegeSelectView: View {
  @State private var searchQuery: String = "대"

  @FocusState private var isSearchFieldFocused: Bool

  private var searchResult: [College] {
    let query = searchQuery.localizedLowercase
    return collegeList
      .filter { $0.name.contains(query) }
  }

  let collegeList: [College]

  @Binding var selectedColleges: [College]

  // MARK: View

  var body: some View {
    content
      .onAppear {
        isSearchFieldFocused = true
      }
  }

  var content: some View {
    VStack(spacing: fs(0)) {
      VStack(spacing: fs(16)) {
        searchHeader
        if selectedColleges.isNotEmpty {
          selectedCollegeChipList
        }
      }
      .padding(.bottom, fs(12))
      .innerStroke(UmpaColor.lightGray, edges: .bottom)

      searchResultList
    }
    .background(.white)
  }

  var searchHeader: some View {
    HStack(spacing: fs(8)) {
      Image(systemSymbol: .magnifyingglass)
        .foregroundStyle(.gray)
      TextField(
        text: $searchQuery,
        prompt: Text("대학명 입력"),
        label: { Text("학교 검색") }
      )
      .focused($isSearchFieldFocused)
      .font(.pretendardMedium(size: fs(16)))
      .foregroundStyle(.black)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, fs(20))
    .padding(.vertical, fs(16))
    .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: fs(10))
    .padding(.horizontal, fs(20))
  }

  var selectedCollegeChipList: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: fs(8)) {
        ForEach(selectedColleges, id: \.name) { college in
          CollegeChip(college: college, destructiveAction: {
            withAnimation {
              selectedColleges.removeAll { $0 == college }
            }
          })
        }
      }
      .padding(.horizontal, fs(24))
    }
    .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
  }

  @ViewBuilder
  var searchResultList: some View {
    List {
      ForEach(searchResult, id: \.name) { college in
        Button {
          withAnimation {
            didTapCollege(college)
          }
        } label: {
          Text(college.name)
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(selectedColleges.contains(college)
              ? UmpaColor.lightGray
              : UmpaColor.darkGray)
        }
        .disabled(selectedColleges.contains(college))
        .buttonStyle(.borderless)
        .listRowInsets(EdgeInsets())
      }
    }
    .listStyle(.plain)
    .padding(.horizontal, fs(28))
    .background(.white)
  }

  private func didTapCollege(_ college: College) {
    if !selectedColleges.contains(college) {
      selectedColleges.append(college)
    }
  }
}

private struct CollegeChip: View {
  private let height: CGFloat = fs(28)
  private let foregroundColor: Color = UmpaColor.mainBlue

  let college: College
  let destructiveAction: () -> Void

  var body: some View {
    HStack(spacing: fs(8)) {
      Text(college.name)
        .font(.pretendardMedium(size: fs(12)))
      Button(action: destructiveAction) {
        Image(systemSymbol: .xmark)
          .font(.system(size: 12, weight: .medium))
          .foregroundStyle(.red)
      }
    }
    .frame(height: height)
    .padding(.horizontal, fs(10))
    .innerRoundedStroke(foregroundColor, cornerRadius: height / 2)
    .foregroundStyle(foregroundColor)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var selectedColleges: [College] = []
  @Previewable @Environment(\.appState) var appState

  CollegeSelectView(collegeList: appState.appData.collegeList, selectedColleges: $selectedColleges)
}
