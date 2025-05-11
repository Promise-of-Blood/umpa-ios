// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct LessonServiceDetailView: View {
  enum TabItem {
    case teacherOverview
    case lessonOverview
    case curriculum
    case review

    var name: String {
      switch self {
      case .teacherOverview:
        "선생님 소개"
      case .lessonOverview:
        "수업 소개"
      case .curriculum:
        "커리큘럼"
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

  let service: LessonService

  private var tabItems: [TabItem] {
    service.curriculum.isEmpty
      ? [.teacherOverview, .lessonOverview, .review]
      : [.teacherOverview, .lessonOverview, .curriculum, .review]
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

  @ViewBuilder
  var content: some View {
    ZStack(alignment: .bottom) {
      ScrollView {
        VStack(spacing: 0) {
          VStack(spacing: fs(20)) {
            Header(service: service)

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
    case .lessonOverview:
      LessonOverviewTabContent(service: service)
    case .curriculum:
      CurriculumTabContent(curriculumList: service.curriculum)
    case .review:
      ReviewTabContent(service: service.eraseToAnyService())
    }
  }
}

private struct Header: View {
  let service: LessonService

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

#Preview {
  #if DEBUG
    @Injected(\.appState) var appState
    appState.userData.loginInfo.currentUser = Student.sample0.eraseToAnyUser()

    return
      NavigationStack {
        LessonServiceDetailView(service: .sample0)
      }
  #endif
}
