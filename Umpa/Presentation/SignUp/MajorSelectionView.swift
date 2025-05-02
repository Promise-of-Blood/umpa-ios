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
    }
}

private struct MajorSelectionButton: View {
    let major: Major
    let isSelected: Bool
    let action: () -> Void

    private let iconSize: CGFloat = fs(26)
    private let iconCornerRadius: CGFloat = fs(14)
    private let buttonSize: CGFloat = fs(52)

    static func hidden() -> some View {
        Self(major: Major(name: ""), isSelected: false, action: {})
            .hidden()
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: fs(4)) {
                Image(major.imageResource)
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

                Text(major.name)
                    .font(.pretendardMedium(size: fs(12)))
                    .foregroundStyle(UmpaColor.darkGray)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: buttonSize)
        }
    }
}

private extension Major {
    var imageResource: ImageResource {
        ImageResource.seeAllIcon
//        switch self {
//        case .piano:
//            return ImageResource(.majorIconPiano)
//        case .vocal:
//            return ImageResource(name: "vocal", bundle: .main)
//        case .composition:
//            return ImageResource(name: "composition", bundle: .main)
//        case .drum:
//            return ImageResource(name: "drum", bundle: .main)
//        case .guitar:
//            return ImageResource(name: "guitar", bundle: .main)
//        case .bass:
//            return ImageResource(name: "bass", bundle: .main)
//        case .brass:
//            return ImageResource(name: "brass", bundle: .main)
//        case .electronicMusic:
//            return ImageResource(name: "electronicMusic", bundle: .main)
//        }
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
