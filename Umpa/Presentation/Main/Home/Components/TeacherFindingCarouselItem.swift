// Created for Umpa in 2025

import SwiftUI

struct TeacherFindingCarouselItem: View {
    let imageResource: ImageResource
    let caption: String

    var body: some View {
        Button(action: {}) {
            VStack(spacing: fs(5)) {
                Image(imageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(fs(10))
                    .background(UmpaColor.lightBlue, in: RoundedRectangle(cornerRadius: fs(15)))
                Text(caption)
                    .font(UmpaFont.captionKr)
                    .foregroundStyle(UmpaColor.darkGray)
                    .frame(width: 60)
                    .lineLimit(1)
            }
            .frame(minWidth: fs(52), maxWidth: fs(60))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TeacherFindingCarouselItem(
        imageResource: .seeAllIcon,
        caption: "전통화성학"
    )
    .frame(width: 52)
    TeacherFindingCarouselItem(
        imageResource: .seeAllIcon,
        caption: "전통화성학"
    )
    .frame(width: 60)
}
