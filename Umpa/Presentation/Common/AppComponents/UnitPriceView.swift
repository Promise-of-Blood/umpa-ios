// Created for Umpa in 2025

import SwiftUI

enum UnitPriceView {}

extension UnitPriceView {
  struct V1: View {
    enum UnitType {
      case hour
      case sheet
      case song
      case school

      var text: String {
        switch self {
        case .hour:
          "시간"
        case .sheet:
          "장"
        case .song:
          "곡"
        case .school:
          "학교"
        }
      }
    }

    struct Model {
      let price: Int
      let unitType: UnitType
    }

    struct Appearance {
      let priceColor: Color
      let priceFontSize: CGFloat

      init(
        priceColor: Color,
        priceFontSize: CGFloat,
      ) {
        self.priceColor = priceColor
        self.priceFontSize = priceFontSize
      }

      static func fromDefault(
        priceColor: Color = .black,
        priceFontSize: CGFloat = fs(15)
      ) -> Appearance {
        Appearance(
          priceColor: priceColor,
          priceFontSize: priceFontSize,
        )
      }
    }

    let model: Model
    let appearance: Appearance

    init(model: Model, appearance: Appearance = .fromDefault()) {
      self.model = model
      self.appearance = appearance
    }

    var body: some View {
      HStack(spacing: fs(3)) {
        HStack(spacing: 0) {
          Text("\(model.price)")
            .font(.pretendardSemiBold(size: appearance.priceFontSize))
          Text("원")
            .font(.pretendardSemiBold(size: appearance.priceFontSize - fs(1)))
        }
        .foregroundStyle(appearance.priceColor)
        Text("/\(model.unitType.text)")
          .foregroundStyle(UmpaColor.mediumGray)
          .font(.pretendardMedium(size: appearance.priceFontSize - fs(1)))
      }
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  UnitPriceView.V1(model: .init(price: 120_000, unitType: .hour))
  UnitPriceView.V1(model: .init(price: 5000, unitType: .sheet))
  UnitPriceView.V1(
    model: .init(price: 120_000_000, unitType: .song),
    appearance: .fromDefault(priceColor: UmpaColor.darkBlue)
  )
  UnitPriceView.V1(model: .init(price: 0, unitType: .school))
}
