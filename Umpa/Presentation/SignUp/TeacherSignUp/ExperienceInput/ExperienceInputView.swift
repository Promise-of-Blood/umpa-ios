// Created for Umpa in 2025

import Domain
import SFSafeSymbols
import SwiftUI

struct ExperienceInputView: View {
    @ObservedObject var signUpModel: TeacherSignUpModel

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: fs(40)) {
            Text("대표 경력을 입력해주세요")
                .font(SignUpSharedUIConstant.titleFont)
                .foregroundStyle(SignUpSharedUIConstant.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: fs(20)) {
                Text("경력사항*")
                    .font(.pretendardMedium(size: fs(16)))
                    .foregroundStyle(UmpaColor.mainBlue)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: fs(14)) {
                    ForEach($signUpModel.experiences) { experience in
                        ExperienceCard(experience: experience) {
                            withAnimation {
                                signUpModel.experiences.removeAll(where: { $0.id == experience.id })
                            }
                        }
                        .id(experience.id)
                        .transition(.blurReplace)
                    }
                    addExperienceButton
                }
            }
        }
    }

    var addExperienceButton: some View {
        Button(action: {}) {
            Image(systemSymbol: .plus)
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(UmpaColor.lightBlue)
                .frame(maxWidth: .infinity, height: fs(50))
                .background(.white)
                .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
        }
    }
}

private struct ExperienceCard: View {
    @Binding var experience: ExperienceModel

    let discardAction: () -> Void

    private let cornerRadius: CGFloat = fs(15)

    var body: some View {
        VStack(alignment: .leading, spacing: fs(10)) {
            Text(experience.title)
                .font(.pretendardBold(size: fs(16)))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(experience.period)
                .font(.pretendardMedium(size: fs(15)))
                .foregroundStyle(UmpaColor.mediumGray)
        }
        .frame(maxWidth: .infinity, minHeight: fs(70))
        .padding(EdgeInsets(top: fs(20), leading: fs(16), bottom: fs(20), trailing: fs(66)))
        .innerRoundedStroke(UmpaColor.mainBlue, cornerRadius: cornerRadius)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(alignment: .topTrailing) {
            toggleSwitch
                .offset(x: fs(-16), y: fs(16))
        }
        .overlay(alignment: .bottomTrailing) {
            discardButton
                .offset(x: fs(-20), y: fs(-16))
        }
    }

    var toggleSwitch: some View {
        ToggleSwitch(
            isOn: $experience.isRepresentative,
            appearance: .appearance(
                circleColor: UmpaColor.mainBlue,
                enabledColor: UmpaColor.lightBlue,
            )
        )
        .scaleEffect(1.2, anchor: .topTrailing)
    }

    var discardButton: some View {
        Button(action: discardAction) {
            Image(systemSymbol: .trash)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.red)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ExperienceInputView(signUpModel: TeacherSignUpModel(socialLoginType: .apple))
}
