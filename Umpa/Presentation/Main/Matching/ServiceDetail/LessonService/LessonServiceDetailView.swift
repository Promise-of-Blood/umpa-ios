// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct LessonServiceDetailView: View {
    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.serviceInteractor) private var serviceInteractor

    private let bottomActionBarHeight: CGFloat = fs(64)

    let service: LessonService
    let tabItems: [TabItem]

    @State private var tabSelection = 0

    init(service: LessonService) {
        self.service = service
        self.tabItems = service.curriculum.isEmpty
            ? [.teacherOverview, .lessonOverview, .review]
            : [.teacherOverview, .lessonOverview, .curriculum, .review]
    }

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    @ViewBuilder
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
                    }
                }
            )
        }
    }

    var segmentedControlContent: AnyView {
        switch tabItems[tabSelection] {
        case .teacherOverview:
            AnyView(TeacherOverviewTabContent(teacher: service.author))
        case .lessonOverview:
            AnyView(LessonOverviewTabContent(service: service))
        case .curriculum:
            AnyView(CurriculumTabContent(curriculumList: service.curriculum))
        case .review:
            AnyView(ReviewTabContent())
        }
    }
}

extension LessonServiceDetailView {
    enum TabItem {
        case teacherOverview
        case lessonOverview
        case curriculum
        case review

        var name: String {
            switch self {
            case .teacherOverview:
                return "선생님 소개"
            case .lessonOverview:
                return "수업 소개"
            case .curriculum:
                return "커리큘럼"
            case .review:
                return "리뷰"
            }
        }
    }
}

#Preview {
    NavigationStack {
        LessonServiceDetailView(service: .sample0)
    }
}
