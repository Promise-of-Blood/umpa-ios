// Created for Umpa in 2025

import BaseFeature
import Domain
import SwiftUI
import UmpaUIKit

struct LessonRequirementView: View {
  @ObservedObject var signUpModel: StudentSignUpModel

  var focusField: FocusState<StudentSignUpView.FocusField?>.Binding

  var body: some View {
    content
  }

  var content: some View {
    ScrollView {
      VStack(spacing: fs(40)) {
        Text("원하는 수업에 대한 정보를 입력해주세요")
          .font(SignUpConstant.titleFont)
          .foregroundStyle(SignUpConstant.titleColor)
          .frame(maxWidth: .infinity, alignment: .leading)

        VStack(spacing: fs(30)) {
          lessonStyleSelectRow
          availableLessonDaysSelectRow
          lessonRequirementsInputRow
        }
      }
    }
    .background(.white)
  }

  var lessonStyleSelectRow: some View {
    VStack(spacing: fs(12)) {
      Text("원하는 수업 방식")
        .font(.pretendardMedium(size: fs(16)))
        .foregroundStyle(UmpaColor.mainBlue)
        .frame(maxWidth: .infinity, alignment: .leading)

      HStack {
        LessonStyleSelectButton(
          lessonStyle: .inPerson,
          isSelected: signUpModel.lessonStyle == .inPerson || signUpModel.lessonStyle == .both,
          action: { didTapLessonStyleSelectButton(lessonStyle: .inPerson) }
        )
        LessonStyleSelectButton(
          lessonStyle: .remote,
          isSelected: signUpModel.lessonStyle == .remote || signUpModel.lessonStyle == .both,
          action: { didTapLessonStyleSelectButton(lessonStyle: .remote) }
        )
      }
      .frame(maxWidth: .infinity)
    }
  }

  var availableLessonDaysSelectRow: some View {
    VStack(spacing: fs(12)) {
      Text("레슨 가능한 요일")
        .font(.pretendardMedium(size: fs(16)))
        .foregroundStyle(UmpaColor.mainBlue)
        .frame(maxWidth: .infinity, alignment: .leading)
      WeekdaySelector.V1(selectedDays: $signUpModel.availableLessonDays.binding)
    }
  }

  var lessonRequirementsInputRow: some View {
    VStack(spacing: fs(12)) {
      Text("원하는 수업 방향")
        .font(.pretendardMedium(size: fs(16)))
        .foregroundStyle(UmpaColor.mainBlue)
        .frame(maxWidth: .infinity, alignment: .leading)
      LessonRequirementsTextEditor(lessonRequirements: $signUpModel.lessonRequirements, focusField: focusField)
    }
  }

  private func didTapLessonStyleSelectButton(lessonStyle: LessonStyle) {
    switch lessonStyle {
    case .inPerson:
      switch signUpModel.lessonStyle {
      case .inPerson:
        signUpModel.lessonStyle = nil
      case .remote:
        signUpModel.lessonStyle = .both
      case .both:
        signUpModel.lessonStyle = .remote
      case .none:
        signUpModel.lessonStyle = .inPerson
      }
    case .remote:
      switch signUpModel.lessonStyle {
      case .inPerson:
        signUpModel.lessonStyle = .both
      case .remote:
        signUpModel.lessonStyle = nil
      case .both:
        signUpModel.lessonStyle = .inPerson
      case .none:
        signUpModel.lessonStyle = .remote
      }
    case .both:
      assertionFailure("둘 다 선택하는 UI는 아직 없습니다.")
    }
  }
}

private struct LessonStyleSelectButton: View {
  let lessonStyle: LessonStyle
  let isSelected: Bool
  let action: () -> Void

  private let cornerRadius: CGFloat = fs(15)

  init(lessonStyle: LessonStyle, isSelected: Bool, action: @escaping () -> Void) {
    self.lessonStyle = lessonStyle
    self.isSelected = isSelected
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      Text(lessonStyle.name)
        .font(.pretendardMedium(size: fs(16)))
        .foregroundStyle(isSelected ? UmpaColor.mainBlue : UmpaColor.mediumGray)
        .frame(maxWidth: .infinity, height: fs(50))
        .background(isSelected ? UmpaColor.lightBlue : .white)
        .innerRoundedStroke(isSelected ? UmpaColor.mainBlue : UmpaColor.baseColor, cornerRadius: cornerRadius)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
  }
}

private struct LessonRequirementsTextEditor: View {
  @Binding var lessonRequirements: String

  var focusField: FocusState<StudentSignUpView.FocusField?>.Binding

  private let font = Font.pretendardMedium(size: fs(14))
  private var fontColor: Color {
    lessonRequirements.isEmpty ? UmpaColor.lightGray : .black
  }

  // 모든 형태에 적용되는 offset 값인지 확실하지 않음
  private let placeholderOffset = CGSize(width: 5, height: 8)

  private let horizontalPadding: CGFloat = fs(12)
  private let verticalPadding: CGFloat = fs(8)

  var body: some View {
    ZStack(alignment: .topLeading) {
      TextEditor(text: $lessonRequirements)
        .font(font)
        .foregroundStyle(fontColor)
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(height: fs(120))
        .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
        .focused(focusField, equals: .lessonRequirements)
      if lessonRequirements.isEmpty {
        placeholder
      }
    }
    .backgroundStyle(.white)
  }

  var placeholder: some View {
    Text("즉흥 연주를 잘하고 싶어요")
      .offset(placeholderOffset)
      .font(font)
      .foregroundStyle(fontColor)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .allowsHitTesting(false)
  }
}

private extension Weekday {
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

private extension LessonStyle {
  var name: String {
    switch self {
    case .inPerson:
      return "대면"
    case .remote:
      return "비대면"
    case .both:
      assertionFailure("현재 both에 해당하는 UI 요소는 없습니다.")
      return "대면/비대면"
    }
  }
}

#Preview {
  @FocusState var focusField: StudentSignUpView.FocusField?
  LessonRequirementView(signUpModel: StudentSignUpModel(socialLoginType: .apple), focusField: $focusField)
}
