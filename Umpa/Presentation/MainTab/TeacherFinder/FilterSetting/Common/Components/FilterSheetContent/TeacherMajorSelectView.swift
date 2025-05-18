// Created for Umpa in 2025

import BaseFeature
import Domain
import Factory
import SwiftUI
import UmpaUIKit

struct TeacherMajorSelectView: View {
  @Environment(AppState.self) private var appState

  @Binding var editingSelectedMajors: Set<Major>

  private let columnCount = 4
  private var rowCount: Int {
    Int(ceil(Double(appState.appData.majorList.count) / Double(columnCount)))
  }

  private var majorGridList: [[Major]] {
    var result: [[Major]] = []
    for i in 0 ..< rowCount {
      let startIndex = i * columnCount
      let endIndex = min(startIndex + columnCount, appState.appData.majorList.count)
      let subArray = Array(appState.appData.majorList[startIndex ..< endIndex])
      result.append(subArray)
    }
    return result
  }

  // MARK: View

  var body: some View {
    content
  }

  var content: some View {
    Grid(verticalSpacing: fs(30)) {
      ForEach(majorGridList, id: \.self) { row in
        GridRow {
          ForEach(row, id: \.self) { major in
            MajorSelectionButton(
              major: MajorItem(major),
              isSelected: editingSelectedMajors.contains(major),
              action: {
                didTapMajorButton(major: major)
              }
            )
            .frame(maxWidth: .infinity)
          }
        }
      }
    }
  }

  private func didTapMajorButton(major: Major) {
    if editingSelectedMajors.contains(major) {
      editingSelectedMajors.remove(major)
    } else {
      editingSelectedMajors.insert(major)
    }
  }
}

private struct MajorItem: UmpaUIKit.MajorItem {
  let name: String
  let imageResource: ImageResource

  init(_ major: Major) {
    name = major.name
    imageResource = .seeAllIcon // FIXME: 리소스 적용
  }
}

#Preview {
  @Previewable @State var editingSelectedMajors: Set<Major> = []

  TeacherMajorSelectView(editingSelectedMajors: $editingSelectedMajors)
}
