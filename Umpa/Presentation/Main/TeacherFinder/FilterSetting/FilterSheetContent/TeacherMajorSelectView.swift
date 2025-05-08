// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct TeacherMajorSelectView: View {
    @Injected(\.appState) private var appState

    @Binding var editingSelectedMajors: Set<Major>

    private let columnCount = 4
    private var rowCount: Int {
        appState.appData.majorList.count / columnCount + (appState.appData.majorList.count % columnCount > 0 ? 1 : 0)
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
                            major: major,
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

    func didTapMajorButton(major: Major) {
        if editingSelectedMajors.contains(major) {
            editingSelectedMajors.remove(major)
        } else {
            editingSelectedMajors.insert(major)
        }
    }
}

#Preview {
    TeacherMajorSelectView(editingSelectedMajors: .constant([]))
}
