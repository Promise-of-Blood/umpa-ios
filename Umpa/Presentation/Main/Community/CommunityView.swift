// Created for Umpa in 2025

import Components
import Factory
import SwiftUI
import Utility

enum TabItem: CaseIterable {
    case acceptanceReview
    case generalBoard
    case mentoring

    var name: String {
        switch self {
        case .acceptanceReview:
            return "합격 후기"
        case .generalBoard:
            return "게시판"
        case .mentoring:
            return "멘토링"
        }
    }
}

struct CommunityView: View {
    @State private var selection = 0

    var body: some View {
        content
    }

    @ViewBuilder
    var content: some View {
        Text("커뮤니티")

        BottomLineSegmentedControl(
            TabItem.allCases.map(\.name),
            selection: $selection,
            appearance: BottomLineSegmentedControl.Appearance(
                buttonWidth: nil,
                activeColor: UmpaColor.main,
                bottomLineHeight: fs(2),
                bottomLineOffset: fs(12),
                font: .pretendardMedium(size: fs(16))
            )
        )
        .padding()
        .frame(height: 60)

        containedView()
            .frame(maxWidth: .fill, maxHeight: .fill)
    }

    func containedView() -> AnyView {
        switch selection {
        case 0:
            return AnyView(AcceptanceReviewTab())
        case 1:
            return AnyView(GeneralBoardTab())
        case 2:
            return AnyView(MentoringTab())
        default:
            assertionFailure("올바르지 않은 인덱스 값이 설정되었습니다.")
            return AnyView(Color.clear)
        }
    }
}

private struct AcceptanceReviewTab: View {
    @Injected(\.acceptanceReviewInteractor) private var acceptanceReviewInteractor

    @State private var hotAcceptanceReviews: [AcceptanceReview] = []
    @State private var currentHotAcceptanceReviewIndex = 0
    @State private var acceptanceReviewList: [AcceptanceReview] = []

    var body: some View {
        content
            .onAppear(perform: loadInitialState)
    }

    var content: some View {
        VStack {
            HotPostsBanner(hotPosts: hotAcceptanceReviews.map { $0.toHotPostsBannerModel() })
                .padding(.horizontal)
            List {
                ForEach(acceptanceReviewList) { acceptanceReview in
                    Text(acceptanceReview.title)
                }
            }
        }
    }

    private func loadInitialState() {
        Task {
            await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    try await acceptanceReviewInteractor.load($acceptanceReviewList)
                }
                group.addTask {
                    try await acceptanceReviewInteractor.loadHotAcceptanceReviews($hotAcceptanceReviews)
                }
            }
        }
    }
}

private struct GeneralBoardTab: View {
    @Injected(\.generalBoardInteractor) private var generalBoardInteractor

    @State private var hotPosts: [Post] = []
    @State private var currentHotPostIndex = 0
    @State private var postList: [Post] = []

    var body: some View {
        content
            .onAppear(perform: loadInitialState)
    }

    var content: some View {
        VStack {
            HotPostsBanner(hotPosts: hotPosts.map { $0.toHotPostsBannerModel() })
                .padding(.horizontal)
            List {
                ForEach(postList) { post in
                    Text(post.title)
                }
            }
        }
    }

    private func loadInitialState() {
        Task {
            await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    try await generalBoardInteractor.load($postList, filter: .all)
                }
                group.addTask {
                    try await generalBoardInteractor.loadHotPosts($hotPosts)
                }
            }
        }
    }
}

private struct MentoringTab: View {
    @Injected(\.mentoringInteractor) private var mentoringInteractor

    @State private var mentoringPostList: [MentoringPost] = []

    var body: some View {
        content
            .onAppear(perform: loadInitialState)
    }

    var content: some View {
        VStack {
            ForEach(mentoringPostList) { mentoringPost in
                Text(mentoringPost.title)
            }
        }
    }

    private func loadInitialState() {
        Task {
            try await mentoringInteractor.load($mentoringPostList)
        }
    }
}

#Preview {
    CommunityView()
}
