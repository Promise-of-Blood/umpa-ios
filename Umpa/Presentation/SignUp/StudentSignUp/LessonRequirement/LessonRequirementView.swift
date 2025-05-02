// Created for Umpa in 2025

import Components
import Domain
import SwiftUI

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
            WeekdaySelector(selectedDays: $signUpModel.availableLessonDays)
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

private struct WeekdaySelector: View {
    @Binding var selectedDays: [Domain.Weekday]

    private let cornerRadius: CGFloat = fs(8)
    private let height: CGFloat = fs(52)

    var body: some View {
        HStack(spacing: fs(0)) {
            IndexingForEach(Domain.Weekday.allCases) { index, weekday in
                Button(action: {
                    didTapWeekday(weekday)
                }) {
                    Text(weekday.name)
                        .font(.pretendardMedium(size: fs(16)))
                        .frame(maxWidth: .infinity, height: height)
                        .foregroundStyle(UmpaColor.mainBlue)
                        .background(selectedDays.contains(weekday) ? UmpaColor.lightBlue : .white)
                }
                if index < Domain.Weekday.allCases.count - 1 {
                    VerticalDivider(color: UmpaColor.mainBlue)
                }
            }
        }
        .frame(height: height)
        .innerRoundedStroke(UmpaColor.mainBlue, cornerRadius: cornerRadius)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    private func didTapWeekday(_ weekday: Domain.Weekday) {
        if selectedDays.contains(weekday) {
            selectedDays.removeAll { $0 == weekday }
        }
        else {
            selectedDays.append(weekday)
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
        case .mon: return "월"
        case .tue: return "화"
        case .wed: return "수"
        case .thu: return "목"
        case .fri: return "금"
        case .sat: return "토"
        case .sun: return "일"
        }
    }
}

#Preview {
    @FocusState var focusField: StudentSignUpView.FocusField?
    LessonRequirementView(signUpModel: StudentSignUpModel(socialLoginType: .apple), focusField: $focusField)
}
