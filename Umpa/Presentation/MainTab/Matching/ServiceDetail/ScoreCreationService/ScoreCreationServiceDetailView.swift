// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct ScoreCreationServiceDetailView: ServiceDetailView {
    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.serviceInteractor) private var serviceInteractor

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
                    Task {
                        try await chatInteractor.createChattingRoom(for: service)
                        // TODO: 채팅으로 이동
                    }
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
            ReviewTabContent(service: service)
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
        ScoreCreationServiceDetailView(service: .sample0)
    }
}
