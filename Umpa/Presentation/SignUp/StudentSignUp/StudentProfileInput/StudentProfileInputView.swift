// Created for Umpa in 2025

import Core
import Domain
import PhotosUI
import SFSafeSymbols
import SwiftUI

struct StudentProfileInputView: View {
    @ObservedObject var signUpModel: StudentSignUpModel

    @State private var pickerItem: PhotosPickerItem?

    private let profileImageSize: CGFloat = fs(150)

    // MARK: View

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: fs(20)) {
            Text("프로필을 입력해 주세요")
                .font(SignUpSharedUIConstant.titleFont)
                .foregroundStyle(SignUpSharedUIConstant.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            inputSection
        }
        .frame(maxWidth: .infinity)
    }

    var inputSection: some View {
        VStack(spacing: fs(40)) {
            profileImageSelectRow
            gradeSelectRow
            genderSelectRow
        }
        .frame(maxWidth: .infinity)
    }

    var profileImageSelectRow: some View {
        PhotosPicker(
            selection: $pickerItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            VStack(spacing: fs(8)) {
                profileImage
                    .frame(width: profileImageSize, height: profileImageSize)
                    .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: profileImageSize / 2)
                    .clipShape(RoundedRectangle(cornerRadius: profileImageSize / 2))
                Text("프로필 사진")
                    .font(.pretendardMedium(size: fs(16)))
                    .foregroundStyle(UmpaColor.mainBlue)
            }
        }
        .onChange(of: pickerItem) { _, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    signUpModel.profileImageData = data
                }
            }
        }
    }

    @ViewBuilder
    var profileImage: some View {
        if let profileImageData = signUpModel.profileImageData,
           let uiImage = UIImage(data: profileImageData)
        {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            ZStack {
                Circle()
                    .foregroundStyle(.white)
                Image(systemSymbol: .plus)
                    .font(.system(size: 50, weight: .heavy))
                    .foregroundStyle(UmpaColor.lightBlue)
            }
        }
    }

    var gradeSelectRow: some View {
        VStack(spacing: fs(8)) {
            Text("학년")
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(UmpaColor.mainBlue)
                .frame(maxWidth: .infinity, alignment: .leading)

            Menu {
                ForEach(Grade.allCases, id: \.rawValue) { grade in
                    Button(action: {
                        signUpModel.grade = grade
                    }) {
                        Text(grade.name)
                    }
                }
            } label: {
                HStack {
                    Text(signUpModel.grade?.name ?? "학년 선택")
                        .font(.pretendardMedium(size: fs(16)))
                    Spacer()
                    Image(systemSymbol: .chevronDown)
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(fs(16))
                .foregroundStyle(signUpModel.grade == nil ? Color(hex: "9E9E9E") : UmpaColor.darkGray)
                .background(.white)
                .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
                .clipShape(RoundedRectangle(cornerRadius: fs(15)))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var genderSelectRow: some View {
        VStack(spacing: fs(8)) {
            Text("성별")
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(UmpaColor.mainBlue)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                GenderSelectButton(gender: .male, isSelected: signUpModel.gender == .male) {
                    signUpModel.gender = .male
                }
                GenderSelectButton(gender: .female, isSelected: signUpModel.gender == .female) {
                    signUpModel.gender = .female
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct GenderSelectButton: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void

    private let cornerRadius: CGFloat = fs(15)

    var body: some View {
        Button(action: action) {
            Text(gender.name)
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(isSelected ? UmpaColor.mainBlue : UmpaColor.mediumGray)
                .frame(maxWidth: .infinity, height: fs(50))
                .background(isSelected ? UmpaColor.lightBlue : .white)
                .innerRoundedStroke(isSelected ? UmpaColor.mainBlue : UmpaColor.baseColor, cornerRadius: cornerRadius)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

private extension Gender {
    var name: String {
        switch self {
        case .male:
            "남성"
        case .female:
            "여성"
        }
    }
}

private extension Grade {
    var name: String {
        switch self {
        case .사회인:
            "사회인"
        case .대학생:
            "대학생"
        case .재수생:
            "재수생"
        case .high1:
            "고등학생 1학년"
        case .high2:
            "고등학생 2학년"
        case .high3:
            "고등학생 3학년"
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StudentProfileInputView(signUpModel: StudentSignUpModel(socialLoginType: .apple))
}
