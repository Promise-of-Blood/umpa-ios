// Created for Umpa in 2025

import SFSafeSymbols
import SwiftUI
import UmpaUIKit

struct TeacherMainProfileCardView: View {
  let model: Model

  let editProfileAction: () -> Void
  let previewProfileAction: () -> Void

  var body: some View {
    content
  }

  var content: some View {
    VStack(spacing: fs(16)) {
      header
      experiences
      bottomButtons
    }
    .padding(.horizontal, fs(16))
    .padding(.vertical, fs(12))
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: fs(10)))
    .shadow(color: .black.opacity(0.1), radius: fs(10), y: fs(2))
    .shadow(color: .black.opacity(0.15), radius: fs(4), y: fs(2))
  }

  var header: some View {
    let imageSize: CGFloat = fs(50)
    return HStack(spacing: fs(12)) {
      AsyncImage(
        url: URL(string: model.profileImageUrl)
      ) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: imageSize, height: imageSize)
          .clipShape(Circle())
      } placeholder: {
        ProgressView()
          .progressViewStyle(.circular)
          .frame(width: imageSize, height: imageSize)
      }
      VStack(spacing: fs(6)) {
        Text(model.name)
          .font(.pretendardSemiBold(size: fs(16)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(model.secondaryInfo)
          .font(.pretendardRegular(size: fs(12)))
          .foregroundStyle(UmpaColor.mediumGray)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var experiences: some View {
    VStack(spacing: fs(6)) {
      IndexingForEach(model.experiences) { _, experience in
        HStack(spacing: fs(6)) {
          Image(systemSymbol: .checkmarkCircleFill)
            .foregroundStyle(UmpaColor.mainBlue)
            .font(.system(size: 16, weight: .medium))
          Text(experience)
            .font(.pretendardRegular(size: fs(13)))
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
        }
      }
    }
    .frame(maxWidth: .infinity)
  }

  var bottomButtons: some View {
    let cornerRadius: CGFloat = fs(8)
    let verticalPadding: CGFloat = fs(8)
    return HStack(spacing: fs(10)) {
      Button(action: editProfileAction) {
        Text("프로필 편집")
          .font(.pretendardRegular(size: fs(13)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity)
          .padding(.vertical, verticalPadding)
          .background(.white)
          .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: cornerRadius)
          .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      }
      Button(action: previewProfileAction) {
        Text("프로필 미리보기")
          .font(.pretendardMedium(size: fs(13)))
          .foregroundStyle(.white)
          .padding(.vertical, verticalPadding)
          .frame(maxWidth: .infinity)
          .background(UmpaColor.skyBlue, in: RoundedRectangle(cornerRadius: cornerRadius))
          .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      }
    }
  }
}

extension TeacherMainProfileCardView {
  struct Model {
    let name: String
    let profileImageUrl: String
    let secondaryInfo: String
    let experiences: [String]
  }
}

#Preview {
  TeacherMainProfileCardView(
    model: .init(name: "장우영 선생님",
                 profileImageUrl: "",
                 secondaryInfo: "베이스 · 서울/연남동 ",
                 experiences: [
                   "호원대학교 베이스 전공 중퇴",
                   "서울예술대학교, 서울예술대학교, 서울예술대학교, 서울예술대학교 베이스 전공 재학중",
                   "AKMU - 롱디 녹음 세션",
                 ]),
    editProfileAction: {
      print("Did Tap edit profile")
    },
    previewProfileAction: {
      print("Did Tap preview profile")
    },
  )
  .padding()
}
