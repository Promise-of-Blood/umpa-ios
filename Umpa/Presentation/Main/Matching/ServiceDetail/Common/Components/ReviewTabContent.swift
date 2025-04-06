// Created for Umpa in 2025

import SwiftUI

struct ReviewTabContent: View {
    @State private var selectedTab: InnerTab = .review

    let service: any Service

    var body: some View {
        content
            .padding(.horizontal, fs(30))
            .padding(.vertical, fs(20))
    }

    var content: some View {
        VStack(alignment: .leading, spacing: fs(10)) {
            topTabHeader
            switch selectedTab {
            case .review:
                VStack(alignment: .leading, spacing: fs(15)) {
                    ratingSection
                    VStack(spacing: fs(16)) {
                        IndexingForEach(service.reviews) { _, review in
                            ReviewCard(review: review)
                        }
                    }
                }
            case .acceptanceReview:
                VStack(spacing: fs(16)) {
                    ForEach(service.acceptanceReviews, id: \.id) { acceptanceReview in
                        AcceptanceReviewCard(acceptanceReview: acceptanceReview)
                    }
                }
            }
        }
    }

    var topTabHeader: some View {
        HStack(spacing: fs(30)) {
            Button(action: {
                selectedTab = .review
            }) {
                Text("리뷰")
                    .font(selectedTab == .review
                        ? .pretendardSemiBold(size: fs(12))
                        : .pretendardMedium(size: fs(12)))
                    .foregroundStyle(selectedTab == .review ? UmpaColor.main : UmpaColor.mediumGray)
            }
            Button(action: {
                selectedTab = .acceptanceReview
            }) {
                Text("합격 후기")
                    .font(selectedTab == .acceptanceReview
                        ? .pretendardSemiBold(size: fs(12))
                        : .pretendardMedium(size: fs(12)))
                    .foregroundStyle(selectedTab == .acceptanceReview ? UmpaColor.main : UmpaColor.mediumGray)
            }
        }
        .frame(maxWidth: .fill, alignment: .leading)
        .padding(.vertical, fs(5))
        .padding(.horizontal, fs(8))
    }

    var ratingSection: some View {
        HStack(spacing: fs(18)) {
            HStack(spacing: fs(8)) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: fs(20), height: fs(20))
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: fs(20), height: fs(20))
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: fs(20), height: fs(20))
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: fs(20), height: fs(20))
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: fs(20), height: fs(20))
            }

            Text("\(String(format: "%.1f", service.rating)) (\(service.reviews.count))")
                .font(.pretendardSemiBold(size: fs(14)))
        }
        .padding(.horizontal, fs(8))
    }
}

extension ReviewTabContent {
    enum InnerTab {
        case review
        case acceptanceReview
    }
}

extension ReviewTabContent {
    struct ReviewCard: View {
        let review: Review

        var body: some View {
            VStack(alignment: .trailing, spacing: fs(8)) {
                VStack(spacing: fs(18)) {
                    header
                    VStack(spacing: fs(13)) {
                        VStack(alignment: .leading, spacing: fs(10)) {
                            Text(review.content)
                                .fontWithLineHeight(font: .pretendardRegular(size: fs(11)), lineHeight: fs(18))
                                .frame(maxWidth: .fill, alignment: .leading)
                            Text("더보기")
                                .font(.pretendardSemiBold(size: fs(10)))
                                .underline()
                        }
                        .frame(maxWidth: .fill)
                        images
                    }
                    .frame(maxWidth: .fill)
                }
                .frame(maxWidth: .fill)
                Text(review.createdAt.description)
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

                        VStack(spacing: fs(2)) {
                            Text(review.writer.username)
                                .font(.pretendardRegular(size: fs(11)))
                            // TODO: 경력?
                            Text("1년 이상")
                                .font(.pretendardRegular(size: fs(11)))
                                .foregroundStyle(UmpaColor.mediumGray)
                        }
                    }
                }
                Spacer()
                HStack(spacing: fs(4)) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: fs(10), height: fs(10))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: fs(10), height: fs(10))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: fs(10), height: fs(10))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: fs(10), height: fs(10))
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: fs(10), height: fs(10))
                }
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
                    }
                    .frame(width: fs(80), height: fs(80))
                    .clipShape(RoundedRectangle(cornerRadius: fs(5)))
                }
            }
        }
    }

    struct AcceptanceReviewCard: View {
        let acceptanceReview: AcceptanceReview

        var createdAt: String {
            // TODO: 날짜 포맷팅
            acceptanceReview.createdAt.formatted()
        }

        private let imageSize: CGFloat = fs(80)

        var body: some View {
            content
                .padding(fs(14))
                .innerRoundedStroke(UmpaColor.lightLightGray, cornerRadius: fs(10), lineWidth: fs(1))
        }

        var content: some View {
            VStack(alignment: .leading, spacing: fs(2)) {
                VStack(alignment: .leading, spacing: fs(16)) {
                    Text("커뮤니티/합격후기")
                        .font(.pretendardRegular(size: fs(11)))
                        .foregroundStyle(UmpaColor.mediumGray)
                    HStack(alignment: .top, spacing: fs(13)) {
                        AsyncImage(url: acceptanceReview.images.first) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: imageSize, height: imageSize)
                        VStack(alignment: .leading, spacing: fs(8)) {
                            Text(acceptanceReview.title)
                                .font(.pretendardSemiBold(size: fs(14)))
                            Text(acceptanceReview.college.name)
                                .font(.pretendardRegular(size: fs(11)))
                                .foregroundStyle(UmpaColor.mediumGray)
                            HStack(spacing: fs(4)) {
                                Text(acceptanceReview.writer.name)
                                    .font(.pretendardRegular(size: fs(11)))
                                    .foregroundStyle(UmpaColor.mediumGray)
                                Circle()
                                    .frame(width: fs(1.5), height: fs(1.5))
                                    .foregroundStyle(UmpaColor.mediumGray)
                                Text(acceptanceReview.writer.major.name)
                                    .font(.pretendardRegular(size: fs(11)))
                                    .foregroundStyle(UmpaColor.mediumGray)
                            }
                        }
                    }
                }
                Text(createdAt)
                    .font(.pretendardRegular(size: fs(11)))
                    .foregroundStyle(UmpaColor.mediumGray)
                    .frame(maxWidth: .fill, alignment: .trailing)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ReviewTabContent(service: LessonService.sample0)
}
