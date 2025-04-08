// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct AccompanistServiceDetailView: ServiceDetailView {
    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.serviceInteractor) private var serviceInteractor

    let service: AccompanistService

    let tabItems: [TabItem] = [.teacherOverview, .accompanimentOverview, .review]

    @State private var tabSelection = 0

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    var content: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: fs(0)) {
                    Header(tabSelection: $tabSelection, service: service)
                    segmentedControlContent
                        .frame(maxWidth: .fill, maxHeight: .fill)
                }
                .padding(.bottom, bottomActionBarHeight)
            }

            BottomActionBar(
                height: bottomActionBarHeight,
                isLiked: false, // TODO: isLiked 를 받아와야 함
                likeButtonAction: { isLiked in
                    if let serviceId = service.id {
                        Task {
                            try await serviceInteractor.markAsLike(isLiked, for: serviceId)
                        }
                    }
                },
                primaryButtonAction: {
                    chatInteractor.startChatting(with: service)
                }
            )
        }
    }

    @ViewBuilder
    var segmentedControlContent: some View {
        switch tabItems[tabSelection] {
        case .teacherOverview:
            TeacherOverviewTabContent(teacher: service.author)
        case .accompanimentOverview:
            ServiceOverviewTabContent(service: service)
        case .review:
            ReviewTabContent(service: service)
        }
    }
}

extension AccompanistServiceDetailView {
    enum TabItem {
        case teacherOverview
        case accompanimentOverview
        case review

        var name: String {
            switch self {
            case .teacherOverview:
                return "선생님 소개"
            case .accompanimentOverview:
                return "반주 정보"
            case .review:
                return "리뷰"
            }
        }
    }
}

#Preview {
    AccompanistServiceDetailView(service: .sample0)
}
