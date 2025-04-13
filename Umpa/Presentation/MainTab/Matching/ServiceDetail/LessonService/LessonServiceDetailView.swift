// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

struct LessonServiceDetailView: ServiceDetailView {
    @InjectedObject(\.appState) private var appState

    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.serviceInteractor) private var serviceInteractor

    let service: LessonService

    var tabItems: [TabItem] {
        service.curriculum.isEmpty
            ? [.teacherOverview, .lessonOverview, .review]
            : [.teacherOverview, .lessonOverview, .curriculum, .review]
    }

    @State private var tabSelection = 0

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
                    serviceInteractor.markAsLike(isLiked, for: service.id)
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
        case .lessonOverview:
            LessonOverviewTabContent(service: service)
        case .curriculum:
            CurriculumTabContent(curriculumList: service.curriculum)
        case .review:
            ReviewTabContent(service: service)
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

#if MOCK
#Preview {
    NavigationStack {
        LessonServiceDetailView(service: .sample0)
    }
}
#endif
