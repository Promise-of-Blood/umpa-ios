// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct LessonServiceDetailView: View {
    @Injected(\.chatInteractor) private var chatInteractor
    @Injected(\.serviceInteractor) private var serviceInteractor

    private let bottomActionBarHeight: CGFloat = fs(50)

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
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    AsyncImage(url: service.thumbnail) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.5)
                    }
                    .frame(maxWidth: .fill, idealHeight: fs(200))
                    .fixedSize(horizontal: false, vertical: true)
                    Text(service.title)
                    LessonInfo(model: LessonInfo.Model(
                        teacher: service.author.name,
                        rating: service.rating,
                        region: service.author.region.description
                    ))
                    PricePerUnit(model: PricePerUnit.Model(price: service.price, unitType: .hour))
                    HStack(spacing: 9) {
                        BadgeView("학력 인증")
                        BadgeView("시범 레슨 운영")
                    }
                    BottomLineSegmentedControl(
                        tabItems.map(\.name),
                        selection: $tabSelection,
                        buttonWidth: fs(70)
                    )
                    .padding(.horizontal, 30)

                    segmentedControlContent
                        .frame(maxWidth: .fill, maxHeight: .fill, alignment: .top)
                        .padding()
                }
                .padding(.bottom, bottomActionBarHeight)
            }
            BottomActionBar(
                height: bottomActionBarHeight,
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
            AnyView(LessonOverviewTab())
        case .curriculum:
            AnyView(CurriculumTab())
        case .review:
            AnyView(ReviewTab())
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

struct LessonOverviewTab: View {
    var body: some View {
        Text("LessonOverviewTab")
    }
}

struct CurriculumTab: View {
    var body: some View {
        Text("CurriculumTab")
    }
}

struct ReviewTab: View {
    var body: some View {
        Text("ReviewTab")
    }
}

#Preview {
    NavigationStack {
        LessonServiceDetailView(service: .sample0)
    }
}
