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
          Header(tabSelection: $tabSelection, service: service)
          segmentedControlContent
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.bottom, ServiceDetailConstant.bottomActionBarHeight)
      }

      BottomActionBar(
        height: ServiceDetailConstant.bottomActionBarHeight,
        isLiked: false, // TODO: isLiked 를 받아와야 함
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
      SamplePreviewTabContent(sampleSheets: service.sampleSheets)
    case .review:
      ReviewTabContent(service: service.eraseToAnyService())
    }
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
