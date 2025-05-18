// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct LessonFeeSelectView: View {
  @Binding var selectedLessonFee: LessonFee

  private var selectedItemBinding: Binding<LessonFeeItem> {
    Binding<LessonFeeItem>(
      get: { LessonFeeItem(lessonFee: selectedLessonFee) },
      set: { selectedLessonFee = $0.lessonFee }
    )
  }

  private let lessonFeeItemList: [LessonFeeItem] = [
    LessonFeeItem(lessonFee: .all),
    LessonFeeItem(lessonFee: .lessThanOrEqual200000krwPerHour),
    LessonFeeItem(lessonFee: .lessThanOrEqual150000krwPerHour),
    LessonFeeItem(lessonFee: .lessThanOrEqual120000krwPerHour),
    LessonFeeItem(lessonFee: .lessThanOrEqual100000krwPerHour),
    LessonFeeItem(lessonFee: .lessThanOrEqual80000krwPerHour),
    LessonFeeItem(lessonFee: .lessThanOrEqual60000krwPerHour),
  ]

  var body: some View {
    RadioButtonList(selectedItem: selectedItemBinding, itemList: lessonFeeItemList)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct LessonFeeItem: RadioButtonItem {
  let lessonFee: LessonFee

  var id: LessonFee {
    lessonFee
  }

  var title: String {
    lessonFee.name
  }
}

private extension LessonFee {
  var name: String {
    switch self {
    case .all:
      "전체"
    case .lessThanOrEqual200000krwPerHour:
      "시간당 20만원 이하"
    case .lessThanOrEqual150000krwPerHour:
      "시간당 15만원 이하"
    case .lessThanOrEqual120000krwPerHour:
      "시간당 12만원 이하"
    case .lessThanOrEqual100000krwPerHour:
      "시간당 10만원 이하"
    case .lessThanOrEqual80000krwPerHour:
      "시간당 8만원 이하"
    case .lessThanOrEqual60000krwPerHour:
      "시간당 6만원 이하"
    }
  }
}

#Preview {
  @Previewable @State var selectedLessonFee: LessonFee = .all

  LessonFeeSelectView(selectedLessonFee: $selectedLessonFee)
}
