// Created for Umpa in 2025

import BaseFeature
import Core
import Domain
import Factory
import SwiftUI
import UmpaUIKit

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

  @Environment(AppState.self) private var appState

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
                activeColor: UmpaColor.mainBlue,
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
      case .lessonOverview:
        LessonOverviewTabContent(service: service)
      case .curriculum:
        CurriculumTabContent(curriculumList: service.curriculum)
      case .review:
        ReviewTabContent(service: service.eraseToAnyService())
      }
    }
    .padding(fs(28))
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

private struct LessonOverviewTabContent: ServiceOverviewTab {
  let service: LessonService

  private let symbolSpacing: CGFloat = fs(26)
  private let symbolSize: CGFloat = fs(22)

  @State private var studioImageIndex = 0

  // MARK: View

  var body: some View {
    VStack(spacing: fs(16)) {
      scheduleCard
      regionCard
      lessonStyleCard
      lessonDescriptionCard
      if service.lessonTargets.isNotEmpty {
        lessonTargetCard
      }
      if service.studioImages.isNotEmpty {
        studioImageCard
      }
    }
  }

  var scheduleCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .calendar)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)

        switch service.scheduleType {
        case .byStudent:
          VStack(spacing: fs(6)) {
            Text("협의 가능")
              .font(.pretendardSemiBold(size: fs(13)))
              .foregroundStyle(.black)
              .frame(maxWidth: .infinity, alignment: .leading)
            Text("학생과 조율해서 결정 해요")
              .font(.pretendardMedium(size: fs(13)))
              .foregroundStyle(UmpaColor.mediumGray)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .frame(maxWidth: .infinity)
        case .fixed:
          Text(service.availableTimes.weekdaysText)
            .font(.pretendardSemiBold(size: fs(13)))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }

  var regionCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .mappinAndEllipse)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)
        Text(service.author.region.name)
          .font(.pretendardSemiBold(size: fs(13)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var lessonStyleCard: some View {
    makeContentCard {
      HStack(spacing: symbolSpacing) {
        Image(systemSymbol: .magazine)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: symbolSize, height: symbolSize)
        VStack(spacing: fs(14)) {
          if [.inPerson, .both].contains(service.lessonStyle) {
            Text("대면 수업")
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          if [.remote, .both].contains(service.lessonStyle) {
            Text("비대면 수업")
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          Text(service.trialPolicy.name)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.pretendardSemiBold(size: fs(13)))
        .foregroundStyle(.black)
      }
    }
  }

  var lessonDescriptionCard: some View {
    makeContentCard {
      VStack(spacing: fs(28)) {
        Text("수업 소개")
          .font(.pretendardSemiBold(size: fs(16)))
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(service.serviceDescription)
          .fontWithLineHeight(font: .pretendardRegular(size: fs(13)), lineHeight: fs(20))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .foregroundStyle(.black)
    }
  }

  var lessonTargetCard: some View {
    makeContentCard {
      VStack(spacing: fs(28)) {
        Text("수업 대상")
          .font(.pretendardSemiBold(size: fs(16)))
          .frame(maxWidth: .infinity, alignment: .leading)

        VStack(spacing: fs(12)) {
          IndexingForEach(service.lessonTargets) { _, lessonTarget in
            Text(lessonTarget.description)
              .font(.pretendardRegular(size: fs(13)))
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      }
      .foregroundStyle(.black)
    }
  }

  var studioImageCard: some View {
    makeContentCard {
      VStack(spacing: fs(28)) {
        Text("작업실 사진")
          .font(.pretendardSemiBold(size: fs(16)))
          .frame(maxWidth: .infinity, alignment: .leading)

        PaginationCarousel(
          pagination: DotsPagination(
            currentIndex: $studioImageIndex,
            pageCount: service.studioImages.count,
            appearance: .fromDefault(
              normalColor: UmpaColor.lightGray,
              highlightColor: UmpaColor.mainBlue,
            ),
          ),
          pageSource: service.studioImages,
        ) { imageUrl in
          AsyncImage(url: imageUrl) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            ProgressView()
              .progressViewStyle(.circular)
          }
        }
        .frame(maxWidth: .infinity, height: fs(210))
      }
    }
  }
}

private struct CurriculumTabContent: View {
  let curriculumList: [LessonService.CurriculumItem]

  private let cornerRadius: CGFloat = fs(10)

  var body: some View {
    VStack(alignment: .leading, spacing: fs(0)) {
      IndexingForEach(curriculumList) { index, curriculum in
        VStack(alignment: .leading, spacing: fs(10)) {
          Text(curriculum.title)
            .font(.pretendardMedium(size: fs(12)))
            .foregroundStyle(UmpaColor.mediumGray)
          Text(curriculum.description)
            .font(.pretendardRegular(size: fs(14)))
            .foregroundStyle(UmpaColor.darkGray)
        }
        .padding(.horizontal, fs(14))
        .padding(.vertical, fs(18))

        if index < curriculumList.count - 1 {
          HorizontalDivider(thickness: fs(1), color: UmpaColor.lightGray)
        }
      }
    }
    .innerRoundedStroke(UmpaColor.lightGray, cornerRadius: cornerRadius, lineWidth: fs(1))
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    .background(.white)
  }
}

private extension Region {
  var name: String {
    "\(regionalLocalGovernment) \(basicLocalGovernment.name)"
  }
}

private extension [TimeByWeekday<HMTime>] {
  var weekdaysText: String {
    map(\.weekday.name).joined(separator: " · ")
  }
}

private extension Weekday {
  var name: String {
    switch self {
    case .mon:
      "월"
    case .tue:
      "화"
    case .wed:
      "수"
    case .thu:
      "목"
    case .fri:
      "금"
    case .sat:
      "토"
    case .sun:
      "일"
    }
  }
}

private extension TrialPolicy {
  var name: String {
    switch self {
    case .paid:
      "유료 시범 레슨"
    case .free:
      "무료 시범 레슨"
    case .notAvailable:
      "시범 레슨 불가"
    }
  }
}

#Preview {
#if DEBUG
  NavigationStack {
    LessonServiceDetailView(service: .sample0)
  }
#endif
}
