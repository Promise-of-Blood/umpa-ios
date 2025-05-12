// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct AccompanistServiceDetailView: View {
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
        "서비스 소개"
      case .samplePreview:
        "샘플 확인"
      case .review:
        "리뷰"
      }
    }
  }

  @InjectedObject(\.appState) private var appState

#if DEBUG
  @Injected(\.stubServiceDetailInteractor) private var serviceDetailInteractor
#else
  @Injected(\.serviceDetailInteractor) private var serviceDetailInteractor
#endif

  let service: AccompanistService

  var tabItems: [TabItem] {
    service.sampleMusics.isEmpty
      ? [.teacherOverview, .serviceOverview, .review]
      : [.teacherOverview, .serviceOverview, .samplePreview, .review]
  }

  @State private var tabSelection = 0

  // MARK: View

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
                activeColor: UmpaColor.mainBlue,
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
        .padding(fs(30))
    case .review:
      ReviewTabContent(service: service.eraseToAnyService())
    }
  }
}

private struct Header: View {
  @Binding var tabSelection: Int

  let service: AccompanistService

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
          Text(service.author.major.name)
            .font(.pretendardRegular(size: fs(12)))
            .foregroundStyle(UmpaColor.mediumGray)
          spacingDot
          StarRating(service.rating)
        }

        UnitPriceView.V1(
          model: .init(price: service.price, unitType: .school),
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
  let service: AccompanistService

  private let symbolSpacing: CGFloat = fs(26)
  private let symbolSize: CGFloat = fs(22)

  // MARK: View

  var body: some View {
    VStack(spacing: fs(16)) {
      scheduleCard
      mrAvailabilityCard
      ensemblePlaceCard
      accompanistDescriptionCard
    }
  }

  var scheduleCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .recordCircleFill)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Group {
            Text("연습")
              .font(.pretendardSemiBold(size: fs(13)))
              .foregroundStyle(.black)

            Group {
              Text("연습 합주 제공 \(service.ensemblePolicy.freeCount)회")
              Text("추가 합주시 회당 \(service.ensemblePolicy.price)원 추가")
            }
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(UmpaColor.mediumGray)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }

  var mrAvailabilityCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .musicNoteTv)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Text("MR(녹음본) 제공")
            .font(.pretendardSemiBold(size: fs(13)))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
          Text(service.isServingMusicRecorded ? "녹음본 제공" : "녹음본 미제공")
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(UmpaColor.mediumGray)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }

  var ensemblePlaceCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .mappinAndEllipse)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        VStack(spacing: fs(6)) {
          Group {
            Text("연습 위치")
              .font(.pretendardSemiBold(size: fs(13)))
              .foregroundStyle(.black)

            Group {
              if service.ensemblePlace.contains(.privateStudio) {
                Text("반주자 개인 작업실")
              }
              if service.ensemblePlace.contains(.rentalStudio) {
                Text("연습실 대여")
              }
              if service.ensemblePlace.contains(.studentPreference) {
                Text("학생과 조율 후 협의 가능")
              }
            }
            .font(.pretendardMedium(size: fs(13)))
            .foregroundStyle(UmpaColor.mediumGray)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }

  var accompanistDescriptionCard: some View {
    makeContentCard {
      VStack(spacing: fs(28)) {
        Text("반주 소개")
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

#Preview {
#if DEBUG
  AccompanistServiceDetailView(service: .sample0)
#endif
}
