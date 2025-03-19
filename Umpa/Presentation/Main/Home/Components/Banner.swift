// Created for Umpa in 2025

import SwiftUI
import UmpaComponents

struct Banner: View {
    @State var currentIndex: Int

    let count: Int

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
            .frame(height: fs(70))
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: fs(10)))
            Text("\(currentIndex + 1)/\(count)")
                .font(.pretendardMedium(size: fs(9)))
                .frame(width: fs(32), height: fs(12))
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: fs(20)))
                .offset(x: fs(-15), y: fs(-8))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Banner(currentIndex: 1, count: 3)
}
