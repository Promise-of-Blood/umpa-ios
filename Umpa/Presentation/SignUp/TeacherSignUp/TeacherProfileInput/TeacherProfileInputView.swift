// Created for Umpa in 2025

import Core
import Domain
import PhotosUI
import SFSafeSymbols
import SwiftUI

struct TeacherProfileInputView: View {
    @ObservedObject var signUpModel: TeacherSignUpModel
    @Binding var isSatisfiedToNextStep: Bool

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
    }

    var inputSection: some View {
        VStack(spacing: fs(40)) {
            profileImageSelectRow
            genderSelectRow
            lessonRegionSelectRow
        }
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

    var genderSelectRow: some View {
        VStack(spacing: fs(8)) {
            Text("성별*")
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

    var lessonRegionSelectRow: some View {
        VStack(spacing: fs(8)) {
            Text("레슨 지역*")
                .font(.pretendardMedium(size: fs(16)))
                .foregroundStyle(UmpaColor.mainBlue)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Image(systemSymbol: .magnifyingglass)
                    .font(.system(size: 16, weight: .medium))
                Text(signUpModel.lessonRegion?.description ?? "지역 선택")
                    .font(.pretendardMedium(size: fs(16)))
            }
            .padding(fs(16))
            .foregroundStyle(signUpModel.lessonRegion == nil ? Color(hex: "9E9E9E") : UmpaColor.darkGray)
            .background(.white)
            .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
            .clipShape(RoundedRectangle(cornerRadius: fs(15)))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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

#Preview {
    TeacherProfileInputView(
        signUpModel: TeacherSignUpModel(socialLoginType: .apple),
        isSatisfiedToNextStep: .constant(false)
    )
}
