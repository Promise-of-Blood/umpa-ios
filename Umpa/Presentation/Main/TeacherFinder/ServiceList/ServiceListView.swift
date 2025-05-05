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

    @Injected(\.appState) private var appState

    #if DEBUG
    @Injected(\.stubServiceListInteractor) private var interactor
    #else
    @Injected(\.serviceListInteractor) private var interactor
    #endif

    @State private var serviceList: [AnyService] = []
    @State private var isShowingServiceTypeSelector = false
    @State private var selectedListType: ListType = .all

    private var serviceType: ServiceType {
        appState.userData.teacherFinder.selectedServiceType
    }

    private var filterList: [some FilterEntry] {
        switch serviceType {
        case .lesson:
            LessonFilterEntry.orderedList
        case .accompanist:
            fatalError("Not implemented")
        case .scoreCreation:
            fatalError("Not implemented")
        case .mrCreation:
            fatalError("Not implemented")
        }
    }

    // MARK: View

    var body: some View {
        content
            .onAppear(perform: loadMatchedServiceList)
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
    }

    @ViewBuilder
    var content: some View {
        VStack(spacing: fs(20)) {
            serviceTypeSelectButton

            BottomLineSegmentedControl(
                ListType.allCases.map(\.name),
                selection: $selectedListType,
            )
            .onChanges(of: selectedListType, action: loadMatchedServiceList)

            filterListRow

            ForEach(serviceList, id: \.id) { service in
                NavigationLink(value: service) {
                    ServiceListItem(model: service.toServiceListItemModel())
                        .padding(.horizontal, fs(20))
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    var serviceTypeSelectButton: some View {
        Button(action: {}) {
            HStack(spacing: fs(10)) {
                Text(appState.userData.teacherFinder.selectedServiceType.name)
                    .font(.pretendardSemiBold(size: fs(20)))
                    .foregroundStyle(.black)
                Image(systemSymbol: isShowingServiceTypeSelector ? .chevronUp : .chevronDown)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, fs(20))
        }
    }

    var filterListRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: fs(8)) {
                filterSettingButton
                ForEach(filterList) { filter in
                    FilterButton(filter: filter)
                }
            }
            .padding(.horizontal, fs(16))
        }
    }

    var filterSettingButton: some View {
        Button(action: {}) {
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

private struct FilterButton<Filter: FilterEntry>: View {
    let filter: Filter

    private let cornerRadius: CGFloat = fs(6)
    private let foregroundColor = UmpaColor.mediumGray

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
