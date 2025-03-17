// Created for Umpa in 2025

import SwiftUI

struct PricePerTime: View {
    let price: Int

    var body: some View {
        HStack(spacing: 3) {
            Text("\(price)원")
            Text("/시간")
                .foregroundStyle(Color(hex: "9E9E9E"))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PricePerTime(price: 120_000)
}
