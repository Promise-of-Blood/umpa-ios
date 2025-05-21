// Created for Umpa in 2025

import BaseFeature
import Core
import Domain
import PhotosUI
import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct TeacherProfileInputView: View {
  @ObservedObject var signUpModel: TeacherSignUpModel
  @Binding var isSatisfiedCurrentInput: Bool

  @State private var pickerItem: PhotosPickerItem?

  @State private var isPresentingRegionSelector = false

  private let profileImageSize: CGFloat = fs(150)

  // MARK: View

  var body: some View {
    content
      .onChanges(of: signUpModel.gender, signUpModel.lessonRegion) {
        isSatisfiedCurrentInput = signUpModel.validateGender() && signUpModel.validateLessonRegion()
      }
      .sheet(isPresented: $isPresentingRegionSelector) {
        LessonRegionSelector(selectedRegion: signUpModel.lessonRegion) { region in
          signUpModel.lessonRegion = region
        }
      }
  }

  var content: some View {
    VStack(spacing: fs(20)) {
      Text("프로필을 입력해 주세요")
        .font(SignUpConstant.titleFont)
        .foregroundStyle(SignUpConstant.titleColor)
        .frame(maxWidth: .infinity, alignment: .leading)
      inputSection
    }
    .background(.white)
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

      Button {
        isPresentingRegionSelector = true
      } label: {
        HStack {
          Image(systemSymbol: .magnifyingglass)
            .font(.system(size: 16, weight: .medium))
          Text(signUpModel.lessonRegion?.description ?? "지역 선택")
            .font(.pretendardMedium(size: fs(16)))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(fs(16))
        .foregroundStyle(signUpModel.lessonRegion == nil ? Color(hex: "9E9E9E") : UmpaColor.darkGray)
        .background(.white)
        .innerRoundedStroke(UmpaColor.baseColor, cornerRadius: fs(15))
        .clipShape(RoundedRectangle(cornerRadius: fs(15)))
      }
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

private struct LessonRegionSelector: View {
  @Environment(\.dismiss) private var dismiss

  @State var selectedRegion: Region?

  let action: (Region?) -> Void

  private var completeButtonBackground: Color {
    selectedRegion == nil ? UmpaColor.lightGray : UmpaColor.mainBlue
  }

  var body: some View {
    VStack(spacing: fs(18)) {
      Text("레슨 지역 선택")
        .font(.pretendardSemiBold(size: fs(20)))
        .foregroundStyle(UmpaColor.darkBlue)
        .frame(maxWidth: .infinity)
      VStack(spacing: 0) {
        UmpaRegionSelector(selectedRegion: $selectedRegion)
          .border(UmpaColor.baseColor)
          .presentationDragIndicator(.visible)
        Button {
#if DEBUG
          UmpaLogger(category: .signUp).log("선택된 지역: \(selectedRegion?.description ?? "없음")", level: .debug)
#endif
          action(selectedRegion)
          dismiss()
        } label: {
          Text("선택 완료")
            .font(.pretendardSemiBold(size: fs(20)))
            .frame(maxWidth: .infinity, height: fs(60))
            .foregroundStyle(.white)
            .background(completeButtonBackground, in: RoundedRectangle(cornerRadius: fs(14)))
            .padding()
        }
        .buttonStyle(.borderless)
        .disabled(selectedRegion == nil)
      }
    }
    .padding(.top, fs(30))
    .background(.white)
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

#Preview {
  TeacherProfileInputView(
    signUpModel: TeacherSignUpModel(socialLoginType: .apple),
    isSatisfiedCurrentInput: .constant(false)
  )
}
