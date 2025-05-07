// Created for Umpa in 2025

import Components
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
                return "전체 서비스"
            case .favorite:
                return "찜한 서비스"
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

    @State private var lessonFilter: LessonFilter = .init()

    @State private var isShowingFilterSettings = false

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
                }
                else if let accompanistService = service.unwrap(as: AccompanistService.self) {
                    AccompanistServiceDetailView(service: accompanistService)
                }
                else if let musicCreationService = service.unwrap(as: MusicCreationService.self) {
                    MrCreationServiceDetailView(service: musicCreationService)
                }
                else if let scoreCreationService = service.unwrap(as: ScoreCreationService.self) {
                    ScoreCreationServiceDetailView(service: scoreCreationService)
                }
            }
            .fullScreenCover(isPresented: $isShowingFilterSettings) {
                LessonFilterSettingView(lessonFilter: lessonFilter)
            }
            .transaction(value: isShowingFilterSettings) { transaction in
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

                FilterListRow(serviceType: serviceType, isShowingFilterSettings: $isShowingFilterSettings)

                ForEach(serviceList, id: \.id) { service in
                    NavigationLink(value: service) {
                        ServiceListItem(model: service.toServiceListItemModel())
                            .padding(.horizontal, fs(20))
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)

            ServiceTypeSelectSheetView(
                selectedServiceType: selectedServiceType,
                isShowingServiceTypeSelector: $isShowingServiceTypeSelectSheet,
            )
            .offset(y: serviceTypeSelectButtonHeight)
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

    @Binding var isShowingFilterSettings: Bool

    private var filterEntries: [any FilterEntry] {
        switch serviceType {
        case .lesson:
            return LessonFilterEntry.allCases
        case .accompanist:
            return AccompanistFilterEntry.allCases
        case .scoreCreation:
            return ScoreCreationFilterEntry.allCases
        case .mrCreation:
            return MRCreationFilterEntry.allCases
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
        Button(action: {
            isShowingFilterSettings = true
        }) {
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

private extension ServiceType {
    var name: String {
        switch self {
        case .lesson:
            return "레슨"
        case .accompanist:
            return "입시 반주"
        case .scoreCreation:
            return "악보 제작"
        case .mrCreation:
            return "MR 제작"
        }
    }
}

#Preview {
    TabView {
        ServiceListView()
            .tabItem {
                Text("선생님 찾기")
            }
    }
}
