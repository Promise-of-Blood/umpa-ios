// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct MrCreationServiceDetailView: View {
  @InjectedObject(\.appState) private var appState

#if DEBUG
  @Injected(\.stubServiceDetailInteractor) private var serviceDetailInteractor
#else
  @Injected(\.serviceDetailInteractor) private var serviceDetailInteractor
#endif

  let service: MusicCreationService

  var tabItems: [TabItem] {
    service.sampleMusics.isEmpty
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
        .padding(.horizontal, fs(30))
        .padding(.vertical, fs(22))
    case .samplePreview:
      SampleMusicPreviewTabContent(sampleMusicList: service.sampleMusics)
        .padding(.horizontal, fs(30))
        .padding(.vertical, fs(22))
    case .review:
      ReviewTabContent(service: service.eraseToAnyService())
    }
  }
}

private struct Header: View {
  @Binding var tabSelection: Int

  let service: MusicCreationService

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

        UnitPriceView.V1(
          model: .init(price: service.price, unitType: .song),
          appearance: .fromDefault(priceColor: .black, priceFontSize: fs(17))
        )
        .padding(.vertical, fs(4))
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
  let service: MusicCreationService

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
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .dollarsign)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Group {
            Text("가격 안내")
              .font(.pretendardSemiBold(size: fs(13)))
              .foregroundStyle(.black)
            Text(service.chargeDescription)
              .font(.pretendardMedium(size: fs(13)))
              .foregroundStyle(UmpaColor.mediumGray)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
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

extension MrCreationServiceDetailView {
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
  MrCreationServiceDetailView(service: .sample0)
}
#endif
