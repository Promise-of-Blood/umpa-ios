// Created for Umpa in 2025

import SwiftUI
import UmpaComponents

struct Banner: View {
    let count = 3
    @State var currentIndex: Int = 1

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Carousel(currentIndex: $currentIndex) {
                Color.red
                    .tag(0)
                Color.blue
                    .tag(1)
                Color.green
                    .tag(2)
            }
            .frame(height: 80)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("\(currentIndex + 1)/\(count)")
                .font(.system(size: 10, weight: .medium))
                .frame(width: 32, height: 12)
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: 20))
                .offset(x: -16, y: -8)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Banner()
}
