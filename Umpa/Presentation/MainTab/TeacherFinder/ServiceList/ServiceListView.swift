// Created for Umpa in 2025

import Components
import Core
import Domain
import Factory
import SFSafeSymbols
import SwiftUI

struct ServiceListView: View {
  enum ListType: Int, CaseIterable {
    case all = 0
    case favorite

    var name: String {
      switch self {
      case .all:
        "전체 서비스"
      case .favorite:
        "찜한 서비스"
      }
    }
  }

  // MARK: Dependencies

  @InjectedObject(\.appState) private var appState

#if DEBUG
  @Injected(\.stubServiceListInteractor) private var interactor
#else
  @Injected(\.serviceListInteractor) private var interactor
#endif

  // MARK: State

  @State private var serviceList: [AnyService] = []
  @State private var isShowingServiceTypeSelectSheet = false
  @State private var selectedListType: ListType = .all

  @State private var lessonFilter = LessonFilter()
  @State private var accompanistFilter = AccompanistFilter()
  @State private var scoreCreationFilter = ScoreCreationFilter()
  @State private var mrCreationFilter = MRCreationFilter()

  @State private var isShowingLessonFilterSettings = false
  @State private var isShowingAccompanistFilterSettings = false
  @State private var isShowingScoreCreationFilterSettings = false
  @State private var isShowingMRCreationFilterSettings = false

  // MARK: Derived State

  private var selectedServiceType: Binding<ServiceType> {
    $appState.userData.teacherFinder.selectedServiceType
  }

  private var serviceType: ServiceType {
    appState.userData.teacherFinder.selectedServiceType
  }

  // MARK: Appearance

  private let serviceTypeSelectButtonHeight: CGFloat = fs(50)

  // MARK: View

  var body: some View {
    content
      .onChange(of: serviceType, initial: true, loadMatchedServiceList)
      .navigationDestination(for: AnyService.self) { service in
        if let lesson = service.unwrap(as: LessonService.self) {
          LessonServiceDetailView(service: lesson)
        } else if let accompanistService = service.unwrap(as: AccompanistService.self) {
          AccompanistServiceDetailView(service: accompanistService)
        } else if let musicCreationService = service.unwrap(as: MusicCreationService.self) {
          MrCreationServiceDetailView(service: musicCreationService)
        } else if let scoreCreationService = service.unwrap(as: ScoreCreationService.self) {
          ScoreCreationServiceDetailView(service: scoreCreationService)
        }
      }
      .fullScreenCover(isPresented: $isShowingLessonFilterSettings) {
        LessonFilterSettingView(lessonFilter: lessonFilter)
      }
      .fullScreenCover(isPresented: $isShowingAccompanistFilterSettings) {
        AccompanistFilterSettingView(accompanistFilter: accompanistFilter)
      }
      .fullScreenCover(isPresented: $isShowingScoreCreationFilterSettings) {
        ScoreCreationFilterSettingView(filter: scoreCreationFilter)
      }
      .fullScreenCover(isPresented: $isShowingMRCreationFilterSettings) {
        MRCreationFilterSettingView(filter: mrCreationFilter)
      }
      .transaction { transaction in
        transaction.disablesAnimations = true
      }
  }

  @ViewBuilder
  var content: some View {
    ZStack(alignment: .top) {
      VStack(spacing: fs(20)) {
        serviceTypeSelectButton
          .transaction { $0.animation = nil }

        BottomLineSegmentedControl(
          ListType.allCases.map(\.name),
          selection: $selectedListType,
        )
        .onChanges(of: selectedListType, action: loadMatchedServiceList)

        FilterListRow(
          serviceType: serviceType,
          isShowingLessonFilterSettings: $isShowingLessonFilterSettings,
          isShowingAccompanistFilterSettings: $isShowingAccompanistFilterSettings,
          isShowingScoreCreationFilterSettings: $isShowingScoreCreationFilterSettings,
          isShowingMRCreationFilterSettings: $isShowingMRCreationFilterSettings,
        )

        listContent
      }
      .frame(maxHeight: .infinity, alignment: .top)

      ServiceTypeSelectSheetView(
        selectedServiceType: selectedServiceType,
        isShowingServiceTypeSelector: $isShowingServiceTypeSelectSheet,
      )
      .offset(y: serviceTypeSelectButtonHeight)
    }
  }

  var listContent: some View {
    VStack(spacing: fs(16)) {
      ForEach(serviceList, id: \.id) { service in
        NavigationLink(value: service) {
          ServiceListItem(model: service.toServiceListItemModel())
        }
        HorizontalDivider(color: UmpaColor.lightGray)
      }
      .padding(.horizontal, fs(20))
    }
  }

  var serviceTypeSelectButton: some View {
    Button(action: {
      withAnimation {
        isShowingServiceTypeSelectSheet.toggle()
      }
    }) {
      HStack(spacing: fs(10)) {
        Text(appState.userData.teacherFinder.selectedServiceType.name)
          .font(.pretendardSemiBold(size: fs(20)))
          .foregroundStyle(.black)
        Image(systemSymbol: isShowingServiceTypeSelectSheet ? .chevronUp : .chevronDown)
          .font(.system(size: 16, weight: .medium))
      }
      .foregroundStyle(.black)
      .frame(maxWidth: .infinity, height: serviceTypeSelectButtonHeight, alignment: .leading)
      .padding(.horizontal, fs(20))
    }
  }

  // MARK: Private Methods

  private func loadMatchedServiceList() {
    switch selectedListType {
    case .all:
      interactor.load(
        $serviceList,
        for: serviceType
      )
    case .favorite:
      interactor.loadFavoriteServices($serviceList)
    }
  }
}

private struct FilterListRow: View {
  let serviceType: ServiceType

  @Binding var isShowingLessonFilterSettings: Bool
  @Binding var isShowingAccompanistFilterSettings: Bool
  @Binding var isShowingScoreCreationFilterSettings: Bool
  @Binding var isShowingMRCreationFilterSettings: Bool

  private var filterEntries: [any FilterEntry] {
    switch serviceType {
    case .lesson:
      LessonFilterEntry.allCases
    case .accompanist:
      AccompanistFilterEntry.allCases
    case .scoreCreation:
      ScoreCreationFilterEntry.allCases
    case .mrCreation:
      MRCreationFilterEntry.allCases
    }
  }

  // MARK: View

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: fs(8)) {
        filterSettingButton
        ForEach(filterEntries, id: \.id) { filter in
          FilterButton(filter: filter)
        }
      }
      .padding(.horizontal, fs(16))
    }
    .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
  }

  var filterSettingButton: some View {
    Button(action: didTapFilterSettingButton) {
      HStack(spacing: fs(5)) {
        Text("필터")
          .font(.pretendardMedium(size: fs(12)))
        Image(systemSymbol: .sliderHorizontal3)
          .font(.system(size: 15, weight: .medium))
      }
      .padding(.horizontal, fs(10))
      .frame(height: fs(28))
      .foregroundStyle(.white)
      .background(UmpaColor.mainBlue, in: RoundedRectangle(cornerRadius: fs(6)))
    }
  }

  func didTapFilterSettingButton() {
    switch serviceType {
    case .lesson:
      isShowingLessonFilterSettings = true
    case .accompanist:
      isShowingAccompanistFilterSettings = true
    case .scoreCreation:
      isShowingScoreCreationFilterSettings = true
    case .mrCreation:
      isShowingMRCreationFilterSettings = true
    }
  }
}

private struct FilterButton: View {
  let filter: any FilterEntry

  private let cornerRadius: CGFloat = fs(6)
  private let foregroundColor = UmpaColor.mediumGray

  // MARK: View

  var body: some View {
    Button(action: {}) {
      HStack(spacing: fs(5)) {
        Text(filter.name)
          .font(.pretendardRegular(size: fs(12)))
          .foregroundStyle(foregroundColor)
        Image(systemSymbol: .chevronDown)
          .foregroundStyle(foregroundColor)
          .font(.system(size: 14))
      }
      .padding(.horizontal, fs(10))
      .frame(height: fs(28))
      .background(Color.white)
      .innerRoundedStroke(foregroundColor, cornerRadius: cornerRadius)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
  }
}

private struct ServiceTypeSelectSheetView: View {
  @Binding var selectedServiceType: ServiceType
  @Binding var isShowingServiceTypeSelector: Bool

  private let serviceTypeList: [ServiceType] = [.lesson, .accompanist, .scoreCreation, .mrCreation]

  // MARK: Appearance

  private let imageSize: CGFloat = fs(40)
  private let cornerRadius: CGFloat = fs(20)
  private let animationDuration: TimeInterval = 0.25

  // MARK: View

  var body: some View {
    ZStack(alignment: .top) {
      dim
      VStack(spacing: fs(16)) {
        ForEach(serviceTypeList, id: \.self) { serviceType in
          Button(action: {
            didTapServiceType(serviceType)
          }) {
            HStack(spacing: fs(20)) {
              Rectangle()
                .frame(width: imageSize, height: imageSize)
              Text(serviceType.name)
                .font(.pretendardSemiBold(size: fs(18)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
            }
          }
        }
      }
      .padding(.horizontal, fs(50))
      .padding(.vertical, fs(35))
      .background(.white)
      .clipShape(.rect(bottomLeadingRadius: cornerRadius, bottomTrailingRadius: cornerRadius))
      .frame(height: isShowingServiceTypeSelector ? nil : 0, alignment: .top)
      .clipped()
    }
    .animation(.easeInOut(duration: animationDuration), value: isShowingServiceTypeSelector)
    .allowsHitTesting(isShowingServiceTypeSelector)
  }

  var dim: some View {
    Color.black.opacity(0.4)
      .ignoresSafeArea()
      .opacity(isShowingServiceTypeSelector ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isShowingServiceTypeSelector = false
        }
      }
  }

  private func didTapServiceType(_ serviceType: ServiceType) {
    withAnimation {
      selectedServiceType = serviceType
      isShowingServiceTypeSelector = false
    }
  }
}

struct ServiceListItem: View {
  struct Model {
    let title: String
    let teacherName: String
    let region: String
    let pricePerUnit: UnitPriceView.V1.Model
    let image: URL?
    let rating: Double
  }

  let model: Model

  private let dotSize: CGFloat = fs(1.5)

  var body: some View {
    HStack(spacing: fs(10)) {
      VStack(alignment: .leading, spacing: fs(8)) {
        Text(model.title)
          .font(.pretendardBold(size: fs(16)))
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
          .lineLimit(1)

        HStack(spacing: fs(4)) {
          Text(model.teacherName)
            .font(.pretendardRegular(size: fs(12)))
            .foregroundStyle(UmpaColor.mediumGray)
            .lineLimit(1)
            .layoutPriority(2)
          spacingDot
          Text(model.region)
            .font(.pretendardRegular(size: fs(12)))
            .foregroundStyle(UmpaColor.mediumGray)
            .lineLimit(1)
        }

        HStack(spacing: fs(4)) {
          UnitPriceView.V1(
            model: model.pricePerUnit,
            appearance: .fromDefault(priceColor: UmpaColor.darkBlue),
          )
          StarRating(model.rating)
        }
      }

      // FIXME: 스켈레톤 이미지 추가
      AsyncImage(url: model.image)
//        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: fs(70), height: fs(70))
        .background(Color(hex: "D9D9D9"))
        .clipShape(Circle())
    }
    .frame(maxWidth: .infinity)
  }

  var spacingDot: some View {
    Circle()
      .frame(width: dotSize, height: dotSize)
      .foregroundStyle(UmpaColor.mediumGray)
  }
}

extension Service {
  fileprivate func toServiceListItemModel() -> ServiceListItem.Model {
    let unitType: UnitPriceView.V1.UnitType = switch type {
    case .lesson: .hour
    case .accompanist: .school
    case .scoreCreation: .sheet
    case .mrCreation: .song
    }

    let price: Int

    let service = clearAnyServiceIfExisted()
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
         let firstPrice = scoreCreationService.priceByMajor.first?.price
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
      pricePerUnit: UnitPriceView.V1.Model(
        price: price,
        unitType: unitType
      ),
      image: thumbnail,
      rating: rating
    )
  }
}

private extension ServiceType {
  var name: String {
    switch self {
    case .lesson:
      "레슨"
    case .accompanist:
      "입시 반주"
    case .scoreCreation:
      "악보 제작"
    case .mrCreation:
      "MR 제작"
    }
  }
}

#Preview {
  TabView {
    NavigationStack {
      ServiceListView()
    }
    .tabItem {
      Text("선생님 찾기")
    }
  }
}
