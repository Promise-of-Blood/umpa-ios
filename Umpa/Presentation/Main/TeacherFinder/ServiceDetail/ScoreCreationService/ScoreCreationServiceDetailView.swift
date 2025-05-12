// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct ScoreCreationServiceDetailView: View {
  @InjectedObject(\.appState) private var appState

#if DEBUG
  @Injected(\.stubServiceDetailInteractor) private var serviceDetailInteractor
#else
  @Injected(\.serviceDetailInteractor) private var serviceDetailInteractor
#endif

  let service: ScoreCreationService

  var tabItems: [TabItem] {
    service.sampleSheets.isEmpty
      ? [.teacherOverview, .serviceOverview, .review]
      : [.teacherOverview, .serviceOverview, .samplePreview, .review]
  }

  @State private var tabSelection = 0

  var body: some View {
    content
      .modifier(NavigationBackButton(.arrowBack))
      .navigationDestination(for: ChatRoom.self) { chatRoom in
        ChatRoomView(chatRoom: chatRoom)
      }
  }

  var content: some View {
    ZStack(alignment: .bottom) {
      ScrollView {
        VStack(spacing: fs(0)) {
          VStack(spacing: fs(20)) {
            Header(tabSelection: $tabSelection, service: service)

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

          segmentedControlContent
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.bottom, ServiceDetailConstant.bottomActionBarHeight)
      }

      ServiceDetailBottomActionBar(
        isLiked: service.isLiked,
        likeButtonAction: { isLiked in
          serviceDetailInteractor.markAsLike(isLiked, for: service.id)
        },
        primaryButtonAction: {
          serviceDetailInteractor.startChat(
            with: service.eraseToAnyService(),
            navigationPath: $appState.routing.teacherFinderNavigationPath
          )
        }
      )
    }
  }

  @ViewBuilder
  var segmentedControlContent: some View {
    switch tabItems[tabSelection] {
    case .teacherOverview:
      TeacherOverviewTabContent(teacher: service.author)
    case .serviceOverview:
      ServiceOverviewTabContent(service: service)
    case .samplePreview:
      SampleSheetPreviewTabContent(sampleSheetList: service.sampleSheets)
    case .review:
      ReviewTabContent(service: service.eraseToAnyService())
    }
  }
}

private struct Header: View {
  @Binding var tabSelection: Int

  let service: ScoreCreationService

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
          StarRating(service.rating)
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

        UnitPriceView.V1(
          model: .init(price: service.basePrice, unitType: .sheet),
          appearance: .fromDefault(priceColor: .black, priceFontSize: fs(17))
        )
        .padding(.vertical, fs(2))
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, fs(30))
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
    .frame(maxWidth: .infinity, height: ServiceDetailConstant.thumbnailHeight)
  }

  var spacingDot: some View {
    Circle()
      .frame(width: dotSize, height: dotSize)
      .foregroundStyle(UmpaColor.mediumGray)
  }
}

private struct ServiceOverviewTabContent: View {
  let service: ScoreCreationService

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

private struct SampleSheetPreviewTabContent: View {
  let sampleSheetList: [SampleSheet]

  private let sheetImageCornerRadius: CGFloat = fs(10)

  var body: some View {
    VStack(spacing: fs(12)) {
      IndexingForEach(sampleSheetList) { _, sampleSheet in
        AsyncImage(url: sampleSheet.url) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          Color.gray.opacity(0.5)
        }
        .frame(maxWidth: .infinity, idealHeight: fs(380))
        .fixedSize(horizontal: false, vertical: true)
        .overlay {
          // TODO: 워터 마크 추가
          Color.blue.opacity(0.1)
        }
        .clipShape(RoundedRectangle(cornerRadius: sheetImageCornerRadius))
        .innerRoundedStroke(
          UmpaColor.lightLightGray,
          cornerRadius: sheetImageCornerRadius,
          lineWidth: fs(1)
        )
      }
    }
    .padding(.horizontal, fs(30))
    .padding(.vertical, fs(22))
  }
}

extension ScoreCreationServiceDetailView {
  enum TabItem {
    case teacherOverview
    case serviceOverview
    case samplePreview
    case review

    var name: String {
      switch self {
      case .teacherOverview:
        "선생님 소개"
      case .serviceOverview:
        "서비스 안내"
      case .samplePreview:
        "샘플 확인"
      case .review:
        "리뷰"
      }
    }
  }
}

#if DEBUG
#Preview {
  ScoreCreationServiceDetailView(service: .sample0)
}
#endif
