// Created for Umpa in 2025

import SwiftUI

struct TeacherFindingCarouselItem: View {
    let imageResource: ImageResource
    let caption: String

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 5) {
                Image(imageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .background(UmpaColor.lightBlue, in: RoundedRectangle(cornerRadius: 15))
                Text(caption)
                    .font(UmpaFont.captionKr)
                    .foregroundStyle(UmpaColor.darkGray)
            }
            .frame(minWidth: 52, maxWidth: 60)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TeacherFindingCarouselItem(
        imageResource: ImageResource(name: "", bundle: .main),
        caption: "전체보기"
    )
}
