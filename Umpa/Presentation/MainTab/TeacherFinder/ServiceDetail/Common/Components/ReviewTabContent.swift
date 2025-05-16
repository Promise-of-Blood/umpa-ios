// Created for Umpa in 2025

import Core
import Domain
import SwiftUI
import UmpaUIKit

struct ReviewTabContent<S: Service>: View {
  enum OrderType: Hashable, CaseIterable {
    case rating
    case date

    var name: String {
      switch self {
      case .rating:
        "별점순"
      case .date:
        "최신순"
      }
    }
  }

  @State private var selectedOrderType: OrderType = .rating
  @State private var isAscending: Bool = false

  @State private var orderedReviewList: [Review] = []

  let service: S

  // MARK: View

  var body: some View {
    content
      .onChanges(of: selectedOrderType, isAscending, initial: true) {
        orderedReviewList = service.reviews.sorted {
          switch selectedOrderType {
          case .rating:
            isAscending ? $0.rating < $1.rating : $0.rating > $1.rating
          case .date:
            isAscending ? $0.createdAt < $1.createdAt : $0.createdAt > $1.createdAt
          }
        }
      }
  }

  var content: some View {
    VStack(spacing: fs(10)) {
      header

      orderingRow

      VStack(spacing: fs(16)) {
        IndexingForEach(orderedReviewList) { _, review in
          ReviewCard(review: review)
        }
      }
    }
  }

  var header: some View {
    VStack(alignment: .leading, spacing: fs(8)) {
      Text("전체 평점")
        .font(.pretendardSemiBold(size: fs(14)))
        .foregroundStyle(.black)

      ratingSection
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  var ratingSection: some View {
    HStack(spacing: fs(12)) {
      FiveStarRating(
        rating: .constant(service.rating),
        appearance: .fromDefault(spacing: fs(4))
      )
      .frame(width: fs(150))
      Text("\(String(format: "%.1f", service.rating)) (\(service.reviews.count))")
        .font(.pretendardSemiBold(size: fs(14)))
    }
  }

  var orderingRow: some View {
    HStack(spacing: fs(16)) {
      ForEach(OrderType.allCases, id: \.self) { orderType in
        Button(action: {
          withTransaction(Transaction(animation: nil)) {
            didTapOrderButton(orderType)
          }
        }) {
          HStack(spacing: fs(4)) {
            Text(orderType.name)
              .font(selectedOrderType == orderType
                ? .pretendardSemiBold(size: fs(12))
                : .pretendardMedium(size: fs(12)))
            if selectedOrderType == orderType {
              Image(isAscending ? .arrowTriangleUpFill : .arrowTriangleDownFill)
                .renderingMode(.template)
            }
          }
          .foregroundStyle(selectedOrderType == orderType ? UmpaColor.mainBlue : UmpaColor.mediumGray)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
  }

  private func didTapOrderButton(_ orderType: OrderType) {
    switch orderType {
    case .rating:
      switch selectedOrderType {
      case .rating:
        isAscending.toggle()
      case .date:
        isAscending = false
        selectedOrderType = .rating
      }
    case .date:
      switch selectedOrderType {
      case .rating:
        isAscending = false
        selectedOrderType = .date
      case .date:
        isAscending.toggle()
      }
    }
  }
}

private struct ReviewCard: View {
  private static let formatter = DateFormatter()

  let review: Review

  var createdAt: String {
    ReviewCard.formatter.dateFormat = "yyyy. MM. dd"
    return ReviewCard.formatter.string(from: review.createdAt)
  }

  var body: some View {
    VStack(alignment: .trailing, spacing: fs(8)) {
      VStack(spacing: fs(18)) {
        header
        VStack(spacing: fs(13)) {
          VStack(alignment: .leading, spacing: fs(10)) {
            Text(review.content)
              .fontWithLineHeight(font: .pretendardRegular(size: fs(11)), lineHeight: fs(18))
              .frame(maxWidth: .infinity, alignment: .leading)
            Text("더보기")
              .font(.pretendardSemiBold(size: fs(10)))
              .underline()
          }
          .frame(maxWidth: .infinity)
          images
        }
        .frame(maxWidth: .infinity)
      }
      .frame(maxWidth: .infinity)

      Text(createdAt)
        .font(.pretendardRegular(size: fs(10)))
        .foregroundStyle(UmpaColor.mediumGray)
    }
    .padding(.horizontal, fs(14))
    .padding(.vertical, fs(16))
    .innerRoundedStroke(UmpaColor.lightLightGray, cornerRadius: fs(10), lineWidth: fs(1))
  }

  var header: some View {
    HStack(alignment: .top) {
      HStack(spacing: fs(20)) {
        HStack(spacing: fs(8)) {
          AsyncImage(url: review.writer.profileImage) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            ProgressView()
          }
          .frame(width: fs(28), height: fs(28))
          .clipShape(Circle())

          VStack(alignment: .leading, spacing: fs(2)) {
            Text(review.writer.username)
              .font(.pretendardRegular(size: fs(11)))
            Text(review.writer.major.name)
              .font(.pretendardRegular(size: fs(11)))
              .foregroundStyle(UmpaColor.mediumGray)
          }
        }
      }

      Spacer()

      FiveStarRating(
        rating: .constant(CGFloat(review.rating.amount)),
        appearance: .fromDefault(spacing: fs(4)),
      )
      .frame(width: fs(66))
      // TODO: 수강 기간 추가하기
    }
  }

  var images: some View {
    HStack(spacing: fs(8)) {
      ForEach(review.images, id: \.self) { imageUrl in
        AsyncImage(url: imageUrl) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        } placeholder: {
          ProgressView()
            .progressViewStyle(.circular)
        }
        .frame(width: fs(80), height: fs(80))
        .clipShape(RoundedRectangle(cornerRadius: fs(5)))
      }
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
#if DEBUG
  ReviewTabContent(service: LessonService.sample0)
#endif
}
