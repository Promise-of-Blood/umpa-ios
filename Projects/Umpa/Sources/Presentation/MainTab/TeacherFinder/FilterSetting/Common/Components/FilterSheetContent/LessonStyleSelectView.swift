// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct LessonStyleSelectView: View {
  @Binding var selectedLessonStyle: LessonStyle

  private let lessonStyleItemList: [LessonStyleItem] = [
    LessonStyleItem(lessonStyle: .both),
    LessonStyleItem(lessonStyle: .inPerson),
    LessonStyleItem(lessonStyle: .remote),
  ]

  private var selectedItemBinding: Binding<LessonStyleItem> {
    Binding(
      get: { LessonStyleItem(lessonStyle: selectedLessonStyle) },
      set: { selectedLessonStyle = $0.lessonStyle }
    )
  }

  var body: some View {
    RadioButtonList(selectedItem: selectedItemBinding, itemList: lessonStyleItemList)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct LessonStyleItem: RadioButtonItem {
  let lessonStyle: LessonStyle

  var id: LessonStyle {
    lessonStyle
  }

  var title: String {
    lessonStyle.name
  }
}

private extension LessonStyle {
  var name: String {
    switch self {
    case .inPerson:
      "대면 과외"
    case .remote:
      "화상 과외"
    case .both:
      "전체"
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var selectedLessonStyle: LessonStyle = .both

  LessonStyleSelectView(selectedLessonStyle: $selectedLessonStyle)
}
