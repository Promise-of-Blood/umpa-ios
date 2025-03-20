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

struct PricePerTime: View {
    let price: Int
    let unitType: UnitType

    var body: some View {
        HStack(spacing: fs(3)) {
            HStack(spacing: 0) {
                Text("\(price)")
                    .font(.pretendardSemiBold(size: fs(15)))
                Text("원")
                    .font(.pretendardSemiBold(size: fs(14)))
            }
            Text("/\(unitType.text)")
                .foregroundStyle(UmpaColor.lightGray)
                .font(.pretendardMedium(size: fs(14)))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PricePerTime(price: 120_000, unitType: .hour)
    PricePerTime(price: 5_000, unitType: .sheet)
    PricePerTime(price: 120_000_000, unitType: .song)
    PricePerTime(price: 0, unitType: .school)
}
