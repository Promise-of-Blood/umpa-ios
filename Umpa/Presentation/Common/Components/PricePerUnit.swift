// Created for Umpa in 2025

import SwiftUI

enum UnitType {
    case hour
    case sheet
    case song
    case school

    var text: String {
        switch self {
        case .hour:
            return "시간"
        case .sheet:
            return "장"
        case .song:
            return "곡"
        case .school:
            return "학교"
        }
    }
}

struct PricePerUnit: View {
    struct Model {
        let price: Int
        let unitType: UnitType
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
            HStack(spacing: 0) {
                Text("\(model.price)")
                    .font(.pretendardSemiBold(size: fs(15)))
                Text("원")
                    .font(.pretendardSemiBold(size: fs(14)))
            }
            .foregroundStyle(attributes.priceColor)
            Text("/\(model.unitType.text)")
                .foregroundStyle(UmpaColor.lightGray)
                .font(.pretendardMedium(size: fs(14)))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PricePerUnit(model: .example1)
    PricePerUnit(model: .example2)
    PricePerUnit(
        model: .example3,
        attributes: PricePerUnit.Attributes(priceColor: UmpaColor.darkBlue)
    )
    PricePerUnit(model: .example4)
}

#if DEBUG
extension PricePerUnit.Model {
    static let example1 = PricePerUnit.Model(price: 120_000, unitType: .hour)
    static let example2 = PricePerUnit.Model(price: 5_000, unitType: .sheet)
    static let example3 = PricePerUnit.Model(price: 120_000_000, unitType: .song)
    static let example4 = PricePerUnit.Model(price: 0, unitType: .school)
}
#endif
