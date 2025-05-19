// Created for Umpa in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct StudentCardView: View {
  let model: Model

  let linkChatAction: () -> Void
  let serviceCheckAction: () -> Void

  var body: some View {
    VStack(spacing: fs(20)) {
      topChipList
      middleContent
      bottomButtons
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, fs(17))
    .padding(.vertical, fs(15))
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: fs(12)))
    .shadow(color: .black.opacity(0.1), radius: fs(10), y: fs(2))
    .shadow(color: .black.opacity(0.15), radius: fs(4), y: fs(2))
  }

  @ViewBuilder
  var topChipList: some View {
    HStack(spacing: fs(8)) {
      model.paymentType.chipView
      model.lessonStatus.chipView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  var middleContent: some View {
    HStack(spacing: fs(8)) {
      thumbnail
      VStack(alignment: .leading, spacing: fs(4)) {
        Text(model.name)
          .font(.pretendardSemiBold(size: fs(16)))
          .foregroundStyle(.black)
        Text(model.secondaryInfo)
          .font(.pretendardRegular(size: fs(12)))
          .foregroundStyle(UmpaColor.mediumGray)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  @ViewBuilder
  var thumbnail: some View {
    let imageSize: CGFloat = fs(40)
    AsyncImage(url: model.thumbnailURL) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
    } placeholder: {
      ProgressView()
        .progressViewStyle(.circular)
    }
    .frame(width: imageSize, height: imageSize)
    .clipShape(Circle())
  }

  @ViewBuilder
  var bottomButtons: some View {
    let cornerRadius: CGFloat = fs(8)
    let verticalPadding: CGFloat = fs(10)
    HStack(spacing: fs(10)) {
      Button(action: linkChatAction) {
        Text("채팅 바로가기")
          .font(.pretendardRegular(size: fs(14)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity)
          .padding(.vertical, verticalPadding)
          .background(.white)
          .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: cornerRadius)
      }
      Button(action: serviceCheckAction) {
        Text("서비스 확인 요청")
          .font(.pretendardMedium(size: fs(14)))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, verticalPadding)
          .background(UmpaColor.mainBlue, in: RoundedRectangle(cornerRadius: cornerRadius))
      }
    }
  }
}

private struct ChipView: View {
  let title: String
  let foregroundColor: Color
  let backgroundColor: Color

  var body: some View {
    Text(title)
      .font(.pretendardMedium(size: fs(12)))
      .foregroundStyle(foregroundColor)
      .padding(.horizontal, fs(8))
      .padding(.vertical, fs(4))
      .background(backgroundColor, in: RoundedRectangle(cornerRadius: .infinity))
  }
}

private extension LessonStatus {
  var name: String {
    switch self {
    case .inProgress:
      "진행중"
    case .completed:
      "레슨 종료"
    }
  }

  var foregroundColor: Color {
    switch self {
    case .inProgress:
      Color(hex: "0CB969")
    case .completed:
      UmpaColor.darkGray
    }
  }

  var backgroundColor: Color {
    switch self {
    case .inProgress:
      Color(hex: "ECFFE7")
    case .completed:
      UmpaColor.lightGray
    }
  }

  var chipView: some View {
    ChipView(
      title: name,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor
    )
  }
}

private extension PaymentType {
  var name: String {
    switch self {
    case .direct:
      "직접 결제"
    case .safe:
      "안심 결제"
    }
  }

  var foregroundColor: Color {
    switch self {
    case .direct:
      Color(hex: "F07E36")
    case .safe:
      UmpaColor.mainBlue
    }
  }

  var backgroundColor: Color {
    switch self {
    case .direct:
      Color(hex: "FFF7E7")
    case .safe:
      UmpaColor.lightBlue
    }
  }

  var chipView: some View {
    ChipView(
      title: name,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor
    )
  }
}

extension StudentCardView {
  struct Model {
    let name: String
    let secondaryInfo: String
    let thumbnailURL: URL?
    let lessonStatus: LessonStatus
    /// 결제 방식
    let paymentType: PaymentType
    /// 수수료 결제 여부
    let isFeePaid: Bool
  }
}

#Preview {
  StudentCardView(
    model: .init(
      name: "음악어려워요",
      secondaryInfo: "작곡 · 고3",
      thumbnailURL: URL(string: ""),
      lessonStatus: .inProgress,
      paymentType: .direct,
      isFeePaid: false,
    ),
    linkChatAction: {
      print(">>> linkChatAction")
    },
    serviceCheckAction: {
      print(">>> serviceCheckAction")
    },
  )
  .padding()
}
