// Created for Umpa in 2025

import Domain
import Factory
import SwiftUI
import UmpaUIKit

struct ScoreCreationServiceDetailView: View {
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

  @Environment(\.appState) private var appState

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
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          DismissButton(.arrowBack)
        }
      }
      .navigationDestination(for: ChatRoom.self) { chatRoom in
        ChatRoomView(chatRoom: chatRoom)
      }
      .toolbar(.hidden, for: .tabBar)
  }

  @ViewBuilder
  var content: some View {
    @Bindable var appState = appState
    ZStack(alignment: .bottom) {
      ScrollView {
        LazyVStack(spacing: fs(0), pinnedViews: .sectionHeaders) {
          Header(service: service)
            .padding(.bottom, fs(4))

          Section {
            segmentedControlContent
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          } header: {
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
            .background(.white)
            .innerStroke(.black.opacity(0.1), edges: .bottom, lineWidth: fs(1))
          }
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
    Group {
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
    .padding(fs(28))
  }
}

private struct Header: View {
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

private struct ServiceOverviewTabContent: ServiceOverviewTab {
  let service: ScoreCreationService

  private let symbolSpacing: CGFloat = fs(26)
  private let symbolSize: CGFloat = fs(22)

  var body: some View {
    VStack(spacing: fs(16)) {
      priceInfoCard
      turnaroundInfoCard
      revisionPolicyInfoCard
      toolsInfoCard
      serviceDescriptionCard
    }
  }

  var priceInfoCard: some View {
    makeContentCard {
      VStack(spacing: fs(18)) {
        HStack(spacing: symbolSpacing) {
          Image(systemSymbol: .dollarsign)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: symbolSize, height: symbolSize)
          Text("가격 안내")
            .font(.pretendardSemiBold(size: fs(13)))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        Grid(horizontalSpacing: fs(0), verticalSpacing: fs(0)) {
          GridRow {
            Text("전공")
              .frame(width: fs(110))
              .padding(.vertical, fs(6))
              .foregroundStyle(UmpaColor.darkGray)
            VerticalDivider(color: UmpaColor.lightGray)
            Text("가격")
              .frame(maxWidth: .infinity)
              .foregroundStyle(UmpaColor.darkGray)
          }
          HorizontalDivider(color: UmpaColor.lightGray)
            .frame(maxWidth: .infinity)
          IndexingForEach(service.priceByMajor) { _, priceByMajor in
            GridRow {
              Text(priceByMajor.major.name)
                .padding(.vertical, fs(6))
              VerticalDivider(color: UmpaColor.lightGray)
              Text("\(priceByMajor.price)원 / 장")
            }
            HorizontalDivider(color: UmpaColor.lightGray)
          }
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(UmpaColor.mediumGray)
        .innerStroke(UmpaColor.lightGray)
        .font(.pretendardMedium(size: fs(14)))
      }
    }
  }

  var turnaroundInfoCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .clock)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Text("평균 소요 시간")
            .font(.pretendardSemiBold(size: fs(13)))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
          Text(service.turnaround.text)
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(UmpaColor.mediumGray)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }

  var revisionPolicyInfoCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .pencil)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Group {
            Text("수정 횟수")
              .font(.pretendardSemiBold(size: fs(13)))
              .foregroundStyle(.black)

            Group {
              Text("무료 수정 \(service.revisionPolicy.freeCount)회")
              Text("이후 수정 비용 \(service.revisionPolicy.price)원")
            }
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(UmpaColor.mediumGray)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }

  var toolsInfoCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .macbook)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Text("사용 프로그램")
            .font(.pretendardSemiBold(size: fs(13)))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)

          IndexingForEach(service.tools) { _, tool in
            Text(tool.name)
              .font(.pretendardMedium(size: fs(13)))
              .foregroundStyle(UmpaColor.mediumGray)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      }
    }
  }

  var serviceDescriptionCard: some View {
    makeContentCard {
      VStack(spacing: fs(28)) {
        Text("서비스 소개")
          .font(.pretendardSemiBold(size: fs(16)))
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(service.serviceDescription)
          .fontWithLineHeight(font: .pretendardRegular(size: fs(13)), lineHeight: fs(20))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .foregroundStyle(.black)
    }
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
  }
}

#Preview {
  NavigationStack {
#if DEBUG
    ScoreCreationServiceDetailView(service: .sample0)
#endif
  }
}
