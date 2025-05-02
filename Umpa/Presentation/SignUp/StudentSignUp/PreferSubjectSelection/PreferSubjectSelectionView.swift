// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI

struct PreferSubjectSelectionView: View {
    @ObservedObject var signUpModel: StudentSignUpModel

    private var subjectList: [Subject] {
        Container.shared.appState.resolve().appData.subjectList
    }

    private let columnCount = 4
    private var rowCount: Int {
        subjectList.count / columnCount + (subjectList.count % columnCount > 0 ? 1 : 0)
    }

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: fs(50)) {
            TitleText("매칭을 원하는 수업 과목을 선택해주세요")

            VStack(spacing: fs(30)) {
                ForEach(0 ..< rowCount, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< columnCount, id: \.self) { column in
                            let index = row * columnCount + column

                            if let subject = subjectList[safe: index] {
                                SubjectSelectionButton(subject: subject, isSelected: signUpModel.preferSubject == subject) {
                                    signUpModel.preferSubject = subject
                                }
                            } else {
                                SubjectSelectionButton.hidden()
                            }

                            if column < columnCount - 1 {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, fs(8))
            .frame(maxWidth: .infinity)
        }
    }
}

private struct SubjectSelectionButton: View {
    let subject: Subject
    let isSelected: Bool
    let action: () -> Void

    private let iconSize: CGFloat = fs(26)
    private let iconCornerRadius: CGFloat = fs(14)
    private let buttonSize: CGFloat = fs(52)

    static func hidden() -> some View {
        // hidden으로 설정하기 위해 생성하기 때문에 subject 값이 의미 없음
        Self(subject: .accompanist, isSelected: false, action: {})
            .hidden()
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: fs(4)) {
                Image(subject.imageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .padding(fs(12))
                    .background(isSelected ? UmpaColor.lightBlue : .white)
                    .innerRoundedStroke(
                        isSelected ? UmpaColor.mainBlue : UmpaColor.lightLightGray,
                        cornerRadius: iconCornerRadius,
                        lineWidth: fs(1.6)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: iconCornerRadius))

                Text(subject.name)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.darkGray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: buttonSize)
        }
    }
}

private extension Subject {
    var imageResource: ImageResource {
        ImageResource.seeAllIcon
//        switch self {
//        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PreferSubjectSelectionView(signUpModel: StudentSignUpModel(socialLoginType: .apple))
}
