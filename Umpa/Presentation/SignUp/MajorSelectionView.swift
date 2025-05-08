// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct MajorSelectionView<Model: MajorSelectableModel>: View {
    @ObservedObject var signUpModel: Model
    @Binding var isSatisfiedCurrentInput: Bool

    private var majorList: [Major] {
        Container.shared.appState.resolve().appData.majorList
    }

    private let columnCount = 4
    private var rowCount: Int {
        majorList.count / columnCount + (majorList.count % columnCount > 0 ? 1 : 0)
    }

    // MARK: View

    var body: some View {
        content
            .onChange(of: signUpModel.major) {
                isSatisfiedCurrentInput = signUpModel.validateMajor()
            }
    }

    var content: some View {
        VStack(spacing: fs(60)) {
            Text("전공을 선택해주세요")
                .font(SignUpConstant.titleFont)
                .foregroundStyle(SignUpConstant.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: fs(30)) {
                ForEach(0 ..< rowCount, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< columnCount, id: \.self) { column in
                            let index = row * columnCount + column

                            if let major = majorList[safe: index] {
                                MajorSelectionButton(major: major, isSelected: signUpModel.major == major) {
                                    signUpModel.major = major
                                }
                            } else {
                                MajorSelectionButton.hidden()
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
        .background(.white)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let model = StudentSignUpModel(socialLoginType: .apple)
    model.major = Major(name: "작곡")

    return
        MajorSelectionView(
            signUpModel: model,
            isSatisfiedCurrentInput: .constant(false)
        )
}
