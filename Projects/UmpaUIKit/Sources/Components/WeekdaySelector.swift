// Created for Umpa in 2025

import SwiftUI

public enum WeekdaySelector {
  public enum Weekday {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun

    var name: String {
      switch self {
      case .mon: "월"
      case .tue: "화"
      case .wed: "수"
      case .thu: "목"
      case .fri: "금"
      case .sat: "토"
      case .sun: "일"
      }
    }
  }

  public struct Appearance {
    let cornerRadius: CGFloat
    let height: CGFloat
    let lineWidth: CGFloat = 1

    /// - Parameters:
    ///   - cornerRadius: 전체 박스 모서리의 둥근 정도.
    ///   - height: 버튼의 높이.
    public static func fromDefault(
      cornerRadius: CGFloat = fs(8),
      height: CGFloat = fs(52)
    ) -> Appearance {
      Appearance(
        cornerRadius: cornerRadius,
        height: height,
      )
    }
  }
}

extension WeekdaySelector {
  public struct V1: View {
    @Binding public var selectedDays: [Weekday]

    private let appearance: Appearance

    private let weekdays: [Weekday] = [
      .mon, .tue, .wed, .thu, .fri, .sat, .sun,
    ]

    public init(selectedDays: Binding<[Weekday]>, appearance: Appearance = .fromDefault()) {
      _selectedDays = selectedDays
      self.appearance = appearance
    }

    public var body: some View {
      HStack(spacing: fs(0)) {
        IndexingForEach(weekdays) { index, weekday in
          Button(action: {
            didTapWeekday(weekday)
          }) {
            Text(weekday.name)
              .font(.pretendardMedium(size: fs(16)))
              .frame(maxWidth: .infinity, height: appearance.height)
              .foregroundStyle(UmpaColor.mainBlue)
              .background(selectedDays.contains(weekday) ? UmpaColor.lightBlue : .white)
              .overlay {
                Rectangle()
                  .stroke(UmpaColor.mainBlue)
              }
          }
        }
      }
      .frame(height: appearance.height - appearance.lineWidth)
      .overlay {
        RoundedRectangle(cornerRadius: appearance.cornerRadius)
          .stroke(UmpaColor.mainBlue)
      }
      .padding(appearance.lineWidth / 2)
      .clipShape(RoundedRectangle(cornerRadius: appearance.cornerRadius + appearance.lineWidth / 2 / 2))
    }

    private func didTapWeekday(_ weekday: Weekday) {
      if selectedDays.contains(weekday) {
        selectedDays.removeAll { $0 == weekday }
      } else {
        selectedDays.append(weekday)
      }
    }
  }
}

#Preview {
  WeekdaySelector.V1(selectedDays: .constant([]))
    .padding()
}
