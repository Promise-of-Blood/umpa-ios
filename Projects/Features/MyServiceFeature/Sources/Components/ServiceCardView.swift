// Created for MyServiceFeature in 2025

import Domain
import SwiftUI
import UmpaUIKit

struct ServiceCardView: View {
  @Bindable var model: Model

  let editAction: () -> Void
  let previewAction: () -> Void

  var body: some View {
    VStack(spacing: fs(12)) {
      VStack(spacing: fs(8)) {
        header
        content
      }
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

  var header: some View {
    HStack(alignment: .top) {
      Text(model.serviceType.name)
        .font(.pretendardRegular(size: fs(12)))
        .foregroundStyle(UmpaColor.darkGray)
      Spacer()
      VStack(spacing: fs(4)) {
        ToggleSwitch(
          isOn: $model.isOpen,
          appearance: .fromDefault(
            enableForegroundColor: UmpaColor.mainBlue,
            enableBackgroundColor: UmpaColor.lightBlue,
          )
        )
        Text(model.isOpen ? "모집중" : "모집중단")
          .font(.pretendardRegular(size: fs(10)))
          .foregroundStyle(UmpaColor.mediumGray)
      }
    }
  }

  @ViewBuilder
  var content: some View {
    let imageSize: CGFloat = fs(100)
    HStack(spacing: fs(12)) {
      AsyncImage(url: model.thumbnailURL) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
      } placeholder: {
        ProgressView()
          .progressViewStyle(.circular)
      }
      .frame(width: imageSize, height: imageSize)

      VStack(alignment: .leading, spacing: fs(8)) {
        Text(model.title)
          .font(.pretendardBold(size: fs(14)))
          .foregroundStyle(.black)
        if let secondaryInfo = model.secondaryInfo {
          Text(secondaryInfo)
            .font(.pretendardRegular(size: fs(12)))
            .foregroundStyle(UmpaColor.mediumGray)
        }
        UnitPriceView.V1(
          model: .init(price: model.unitPrice, unitType: model.serviceType.unitType),
          appearance: .fromDefault(priceColor: UmpaColor.darkBlue, priceFontSize: fs(15)),
        )
        HStack(spacing: fs(8)) {
          StarRating(5.0) // FIXME: View 이름 붙이기
          Text("(\(model.reviewCount)개 리뷰)")
            .font(.pretendardMedium(size: fs(12)))
            .foregroundStyle(UmpaColor.mediumGray)
        }
      }
      .frame(maxWidth: .infinity)
    }
  }

  @ViewBuilder
  var bottomButtons: some View {
    let cornerRadius: CGFloat = fs(8)
    let verticalPadding: CGFloat = fs(10)
    HStack(spacing: fs(10)) {
      Button(action: editAction) {
        Text("서비스 편집")
          .font(.pretendardRegular(size: fs(14)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity)
          .padding(.vertical, verticalPadding)
          .background(.white)
          .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: cornerRadius)
      }
      Button(action: previewAction) {
        Text("미리보기")
          .font(.pretendardMedium(size: fs(14)))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, verticalPadding)
          .background(UmpaColor.skyBlue, in: RoundedRectangle(cornerRadius: cornerRadius))
      }
    }
  }
}

extension ServiceCardView {
  @Observable
  final class Model {
    let serviceType: ServiceType
    /// 모집중인지 여부
    var isOpen: Bool
    let title: String
    let secondaryInfo: String?
    /// 단위 가격
    let unitPrice: Int
    let rating: Float
    let reviewCount: Int
    let thumbnailURL: URL?

    init(
      serviceType: ServiceType,
      isOpen: Bool,
      title: String,
      secondaryInfo: String?,
      unitPrice: Int,
      rating: Float,
      reviewCount: Int,
      thumbnailURL: URL?,
    ) {
      self.serviceType = serviceType
      self.isOpen = isOpen
      self.title = title
      self.secondaryInfo = secondaryInfo
      self.unitPrice = unitPrice
      self.rating = rating
      self.reviewCount = reviewCount
      self.thumbnailURL = thumbnailURL
    }
  }
}

private extension ServiceType {
  var name: String {
    switch self {
    case .lesson:
      "레슨"
    case .accompanist:
      "입시반주"
    case .scoreCreation:
      "악보제작"
    case .mrCreation:
      "MR제작"
    }
  }

  var unitType: UnitPriceView.UnitType {
    switch self {
    case .lesson:
      .hour
    case .accompanist:
      .school
    case .scoreCreation:
      .sheet
    case .mrCreation:
      .song
    }
  }
}

#Preview {
  ServiceCardView(
    model: .init(
      serviceType: .lesson,
      isOpen: true,
      title: "가고싶은 학교 무조건 가는 방법",
      secondaryInfo: "베이스 · 음파/음파동",
      unitPrice: 120_000,
      rating: 4.7,
      reviewCount: 32,
      thumbnailURL: URL(string: ""),
    ),
    editAction: {
      print("Edit action")
    },
    previewAction: {
      print("Preview action")
    }
  )
  .padding()
}
