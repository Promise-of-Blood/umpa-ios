// Created for Umpa in 2025

import SwiftUI

struct ServiceDetailPricePerUnit: View {
    struct Model {
        let price: Int
        let unitType: PriceUnitType
    }

    struct Attributes {
        let priceColor: Color

        init(priceColor: Color = .black) {
            self.priceColor = priceColor
        }
    }

    let model: Model
    let attributes: Attributes

    init(model: Model, attributes: Attributes = Attributes()) {
        self.model = model
        self.attributes = attributes
    }

    var body: some View {
        HStack(spacing: fs(3)) {
            HStack(spacing: fs(0)) {
                Text("\(model.price)")
                    .font(.pretendardSemiBold(size: fs(17)))
                Text("원")
                    .font(.pretendardSemiBold(size: fs(16)))
            }
            .foregroundStyle(attributes.priceColor)
            Text("/\(model.unitType.text)")
                .foregroundStyle(UmpaColor.mediumGray)
                .font(.pretendardMedium(size: fs(16)))
        }
    }
}

#Preview {
    ServiceDetailPricePerUnit(model: ServiceDetailPricePerUnit.Model(price: 20_000, unitType: .sheet))
}
