// Created for Umpa in 2025

import Components
import SwiftUI

struct Banner: View {
    @State private var currentIndex: Int = 0

    let bannerResources: [ImageResource]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Carousel(currentIndex: $currentIndex) {
                IndexingForEach(bannerResources) { index, resource in
                    Image(resource)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .tag(index)
                }
            }
            .frame(height: fs(70))
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: fs(10)))
            Text("\(currentIndex + 1)/\(bannerResources.count)")
                .font(.pretendardMedium(size: fs(9)))
                .frame(width: fs(32), height: fs(12))
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: fs(20)))
                .offset(x: fs(-15), y: fs(-8))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var index = 1
    Banner(
        bannerResources: [
            .bannerSample1,
            .bannerSample1,
            .bannerSample1,
        ]
    )
}
