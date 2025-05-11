// Created for Umpa in 2025

import Components
import Domain
import SwiftUI

extension LessonServiceDetailView {
  struct Header: View {
    @Binding var tabSelection: Int

    let service: LessonService

    var tabItems: [TabItem] {
      service.curriculum.isEmpty
        ? [.teacherOverview, .lessonOverview, .review]
        : [.teacherOverview, .lessonOverview, .curriculum, .review]
    }

    private let dotSize: CGFloat = fs(1.5)

    var body: some View {
      VStack(spacing: fs(20)) {
        AsyncImage(url: service.thumbnail) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        } placeholder: {
          Color.gray
        }
        .frame(maxWidth: .infinity, idealHeight: fs(374))
        .fixedSize(horizontal: false, vertical: true)

        VStack(alignment: .leading, spacing: fs(6)) {
          Text(service.title)
            .font(.pretendardBold(size: fs(20)))

          HStack(spacing: fs(4)) {
            Text(service.author.name)
              .font(.pretendardRegular(size: fs(12)))
              .foregroundStyle(UmpaColor.mediumGray)
            spacingDot
            StarRating(service.rating)
            spacingDot
            Text(service.author.region.description)
              .font(.pretendardRegular(size: fs(12)))
              .foregroundStyle(UmpaColor.mediumGray)
          }

          UnitPriceView.V1(
            model: .init(price: service.price, unitType: .hour),
            appearance: .fromDefault(priceColor: .black, priceFontSize: fs(17))
          )
          .padding(.vertical, fs(4))

          HStack(spacing: fs(9)) {
            BadgeView("학력 인증")
            BadgeView("시범 레슨 운영")
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, fs(30))

        BottomLineSegmentedControl(
          tabItems.map(\.name),
          selection: $tabSelection,
          appearance: .appearance(
            buttonWidth: fs(70),
            activeColor: UmpaColor.main,
            bottomLineHeight: fs(2),
            bottomLineOffset: fs(11),
            activeFont: .pretendardSemiBold(size: fs(14)),
            inactiveFont: .pretendardRegular(size: fs(14))
          )
        )
        .padding(.horizontal, fs(26))
        .innerStroke(.black.opacity(0.1), edges: .bottom, lineWidth: fs(1))
      }
      .background(.white)
    }

    var spacingDot: some View {
      Circle()
        .frame(width: dotSize, height: dotSize)
        .foregroundStyle(UmpaColor.mediumGray)
    }
  }
}

#Preview {
  @Previewable @State var tabSelection = 1

  #if DEBUG
    LessonServiceDetailView.Header(tabSelection: $tabSelection, service: .sample0)
      .padding()
      .background(.black)
  #endif
}
