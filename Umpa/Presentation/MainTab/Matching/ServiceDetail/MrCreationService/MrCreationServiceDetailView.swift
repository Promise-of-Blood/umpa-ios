// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct MrCreationServiceDetailView: ServiceDetailView {
    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.serviceInteractor) private var serviceInteractor

    let service: MusicCreationService

    var tabItems: [TabItem] {
        service.sampleMusics.isEmpty
            ? [.teacherOverview, .serviceOverview, .review]
            : [.teacherOverview, .serviceOverview, .samplePreview, .review]
    }

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
        case .serviceOverview:
            ServiceOverviewTabContent(service: service)
        case .samplePreview:
            SamplePreviewTabContent(sampleMusics: service.sampleMusics)
        case .review:
            ReviewTabContent(service: service)
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
                return "선생님 소개"
            case .serviceOverview:
                return "서비스 안내"
            case .samplePreview:
                return "샘플 확인"
            case .review:
                return "리뷰"
            }
        }
    }
}

#Preview {
    NavigationStack {
        MrCreationServiceDetailView(service: .sample0)
    }
}
