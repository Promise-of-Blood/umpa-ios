// Created for Umpa in 2025

import Core
import Domain
import SwiftUI

struct ServiceListItem: View {
    struct Model {
        let title: String
        let teacherName: String
        let region: String
        let pricePerUnit: PricePerUnit.Model
        let image: URL?
        let rating: Double
    }

    let model: Model

    var body: some View {
        HStack(spacing: fs(10)) {
            VStack(alignment: .leading, spacing: fs(8)) {
                Text(model.title)
                    .font(.pretendardBold(size: fs(16)))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)

                LessonInfoView(teacher: model.teacherName, region: model.region)

                HStack(spacing: fs(4)) {
                    PricePerUnit(
                        model: model.pricePerUnit,
                        attributes: PricePerUnit.Attributes(priceColor: UmpaColor.darkBlue)
                    )
                    StarRating(model.rating)
                }
            }
            // FIXME: 스켈레톤 이미지 추가
            AsyncImage(url: model.image)
//                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: fs(70), height: fs(70))
                .background(Color(hex: "D9D9D9"))
                .clipShape(Circle())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, fs(16))
    }
}

private struct LessonInfoView: View {
    let teacher: String
    let region: String

    private let dotSize: CGFloat = fs(1.5)

    var body: some View {
        HStack(spacing: fs(4)) {
            Text(teacher)
                .font(.pretendardRegular(size: fs(12)))
                .foregroundStyle(UmpaColor.mediumGray)
                .lineLimit(1)
                .layoutPriority(2)
            spacingDot
            Text(region)
                .font(.pretendardRegular(size: fs(12)))
                .foregroundStyle(UmpaColor.mediumGray)
                .lineLimit(1)
        }
    }

    var spacingDot: some View {
        Circle()
            .frame(width: dotSize, height: dotSize)
            .foregroundStyle(UmpaColor.mediumGray)
    }
}

extension Service {
    func toServiceListItemModel() -> ServiceListItem.Model {
        let unitType: PriceUnitType = switch type {
        case .lesson: .hour
        case .accompanist: .school
        case .scoreCreation: .sheet
        case .mrCreation: .song
        }

        let price: Int

        let service = cleaerAnyServiceIfExisted()
        switch service.type {
        case .lesson, .accompanist, .mrCreation:
            if let singlePriceService = (service as? any SinglePriceService) {
                price = singlePriceService.price
            } else {
                UmpaLogger(category: .ui).log("\(service.type) 변환 실패", level: .error)
                assertionFailure("여기로 오면 안됨;;")
                price = 0
            }
        case .scoreCreation:
            if let scoreCreationService = service as? ScoreCreationService,
               let firstPrice = scoreCreationService.pricesByMajor.first?.price
            {
                price = firstPrice
            } else {
                UmpaLogger(category: .ui).log("\(service.type) 변환 실패", level: .error)
                assertionFailure("여기로 오면 안됨;;")
                price = 0
            }
        }

        return ServiceListItem.Model(
            title: title,
            teacherName: author.name,
            region: author.region.description,
            pricePerUnit: PricePerUnit.Model(
                price: price,
                unitType: unitType
            ),
            image: thumbnail,
            rating: rating
        )
    }
}

// #if DEBUG
// #Preview(traits: .sizeThatFitsLayout) {
//    ServiceListItem(model: ServiceListItem.Model.example1)
//        .frame(width: 280)
//        .border(Color.black)
//        .padding()
//        .border(Color.black)
//    ServiceListItem(model: ServiceListItem.Model.example2)
//        .frame(width: 320)
//        .border(Color.black)
//        .padding()
//        .border(Color.black)
// }
// #endif

// #if DEBUG
// extension ServiceListItem.Model {
//    static let example1 = ServiceListItem.Model(
//        title: "가고 싶은 학교 무조건 가는 방법",
//        lessonInfo: LessonInfo.Model.example1,
//        pricePerUnit: PricePerUnit.Model.example1,
//        image: nil
//    )
//
//    static let example2 = ServiceListItem.Model(
//        title: "초견 때문에 입시가 두려우신 분 들어 오던지 말던지",
//        lessonInfo: LessonInfo.Model.example2,
//        pricePerUnit: PricePerUnit.Model.example3,
//        image: URL(string: "https://file.daesoon.org/webzine/307/202212191656_Daesoon_263_%EB%AC%B8%ED%99%94%EC%82%B0%EC%B1%85_%EC%A0%84%EA%B2%BD%20%EC%86%8D%20%EB%8F%99%EB%AC%BC%20%EA%B3%A0%EC%96%91.jpg")
//    )
// }
// #endif
