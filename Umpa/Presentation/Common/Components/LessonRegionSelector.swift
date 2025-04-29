// Created for Umpa in 2025

import Factory
import SwiftUI

public struct LessonRegionSelector: View {
    @Injected(\.appState) private var appState

    private var regionalLocalGovernmentList: [String] {
        appState.appData.regionalLocalGovernmentList
    }

    private var basicLocalGovernmentList: [String] {
        appState.appData.basicLocalGovernmentList
    }

    let selectionBackgroundColor: Color = .init(hex: "D6E1FF")
    let selectionForegroundColor: Color = .init(hex: "003BDE")
    let badgeForegroundColor: Color = UmpaColor.mainBlue

    let canMultiSelect: Bool

    init(canMultiSelect: Bool = false) {
        self.canMultiSelect = canMultiSelect
    }

    // MARK: View

    public var body: some View {
        content
    }

    var content: some View {
        HStack(spacing: 1) {
            ScrollView {
                IndexingForEach(regionalLocalGovernmentList) { _, name in
                    Text(name)
                }
            }
            ScrollView {
                IndexingForEach(basicLocalGovernmentList) { _, name in
                    Text(name)
                }
            }
        }
    }
}

#Preview {
    LessonRegionSelector()
}
