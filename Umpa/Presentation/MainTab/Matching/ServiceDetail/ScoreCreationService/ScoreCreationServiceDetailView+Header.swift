// Created for Umpa in 2025

import Components
import Domain
import SwiftUI

extension ScoreCreationServiceDetailView {
    struct Header: View {
        @Binding var tabSelection: Int

        let service: ScoreCreationService

        var tabItems: [TabItem] {
            service.sampleSheets.isEmpty
                ? [.teacherOverview, .serviceOverview, .review]
                : [.teacherOverview, .serviceOverview, .samplePreview, .review]
        }

        private let dotSize: CGFloat = fs(1.5)

        var body: some View {
            VStack(spacing: fs(20)) {
                thumbnail
                VStack(alignment: .leading, spacing: fs(6)) {
                    Text(service.title)
                        .font(.pretendardBold(size: fs(20)))

                    HStack(spacing: fs(4)) {
                        Text(service.author.name)
                            .font(.pretendardRegular(size: fs(12)))
                            .foregroundStyle(UmpaColor.mediumGray)
                        spacingDot
                        Rating(service.rating)
                    }

                    HStack(spacing: fs(10)) {
                        ForEach(service.majors, id: \.self) { major in
                            Text(major.name)
                                .font(.pretendardMedium(size: fs(12)))
                                .padding(.horizontal, fs(16))
                                .padding(.vertical, fs(6))
                                .background(Color(hex: "E5EEFF"), in: Capsule())
                        }
                    }
                    .padding(.vertical, fs(8))

                    ServiceDetailPricePerUnit(model: .init(price: service.basePrice, unitType: .sheet))
                        .padding(.vertical, fs(2))
                }
                .frame(maxWidth: .fill, alignment: .leading)
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

        var thumbnail: some View {
            AsyncImage(url: service.thumbnail) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(maxWidth: .fill, idealHeight: fs(374))
            .fixedSize(horizontal: false, vertical: true)
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

    ScoreCreationServiceDetailView.Header(tabSelection: $tabSelection, service: .sample0)
        .padding()
        .background(.black)
}
