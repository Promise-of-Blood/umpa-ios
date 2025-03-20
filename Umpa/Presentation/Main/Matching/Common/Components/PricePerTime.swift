// Created for Umpa in 2025

import SwiftUI

struct PricePerTime: View {
    let price: Int

    var body: some View {
        HStack(spacing: 3) {
            Text("\(price)원")
            Text("/시간")
                .foregroundStyle(UmpaColor.lightGray)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PricePerTime(price: 120_000)
}
