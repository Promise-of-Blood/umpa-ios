// Created for Umpa in 2025

import Domain
import SwiftUI

struct ServiceListItem: View {
    struct Model {
        let title: String
        let lessonInfo: LessonInfo.Model
        let pricePerUnit: PricePerUnit.Model
        let image: URL?
    }

    let model: Model

    var body: some View {
        HStack(spacing: fs(10)) {
            VStack(alignment: .leading, spacing: fs(8)) {
                Text(self.model.title)
                    .font(.pretendardBold(size: fs(16)))
                    .foregroundStyle(Color(hex: "121214"))
                    .frame(maxWidth: .fill, alignment: .leading)
                    .lineLimit(1)
                LessonInfo(model: self.model.lessonInfo)
                PricePerUnit(
                    model: self.model.pricePerUnit,
                    attributes: PricePerUnit.Attributes(priceColor: UmpaColor.darkBlue)
                )
            }
            // FIXME: 스켈레톤 이미지 추가
            AsyncImage(url: self.model.image)
//                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: fs(70), height: fs(70))
                .background(Color(hex: "D9D9D9"))
                .clipShape(Circle())
        }
        .frame(maxWidth: .fill)
        .padding(.horizontal, fs(2))
        .padding(.vertical, fs(16))
    }
}

extension Service {
    func toServiceListItemModel() -> ServiceListItem.Model {
        let unitType: PriceUnitType = switch self.type {
        case .lesson: .hour
        case .accompanist: .school
        case .scoreCreation: .sheet
        case .mrCreation: .song
        @unknown default:
            .unknown
        }

        let price: Int
        switch self.type {
        case .lesson, .accompanist, .mrCreation:
            if let service = (self as? any SinglePriceService) {
                price = service.price
            } else {
                // TODO: 예상치 못한 케이스, 내부 로직 버그 가능성, 로그 심기
                price = 0
            }
        case .scoreCreation:
            if let service = self as? ScoreCreationService,
               let firstPrice = service.pricesByMajor.first?.price
            {
                price = firstPrice
            } else {
                // TODO: 예상치 못한 케이스, 내부 로직 버그 가능성, 로그 심기
                price = 0
            }
        @unknown default:
            // TODO: 예상치 못한 케이스, 내부 로직 버그 가능성, 로그 심기
            price = 0
        }

        return ServiceListItem.Model(
            title: self.title,
            lessonInfo: LessonInfo.Model(
                teacher: self.author.name,
                rating: self.rating,
                region: self.author.region.description
            ),
            pricePerUnit: PricePerUnit.Model(
                price: price,
                unitType: unitType
            ),
            image: self.thumbnail
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ServiceListItem(model: ServiceListItem.Model.example1)
        .frame(width: 280)
        .border(Color.black)
        .padding()
        .border(Color.black)
    ServiceListItem(model: ServiceListItem.Model.example2)
        .frame(width: 320)
        .border(Color.black)
        .padding()
        .border(Color.black)
}

#if DEBUG
extension ServiceListItem.Model {
    static let example1 = ServiceListItem.Model(
        title: "가고 싶은 학교 무조건 가는 방법",
        lessonInfo: LessonInfo.Model.example1,
        pricePerUnit: PricePerUnit.Model.example1,
        image: nil
    )

    static let example2 = ServiceListItem.Model(
        title: "초견 때문에 입시가 두려우신 분 들어 오던지 말던지",
        lessonInfo: LessonInfo.Model.example2,
        pricePerUnit: PricePerUnit.Model.example3,
        image: URL(string: "https://file.daesoon.org/webzine/307/202212191656_Daesoon_263_%EB%AC%B8%ED%99%94%EC%82%B0%EC%B1%85_%EC%A0%84%EA%B2%BD%20%EC%86%8D%20%EB%8F%99%EB%AC%BC%20%EA%B3%A0%EC%96%91.jpg")
    )
}
#endif
