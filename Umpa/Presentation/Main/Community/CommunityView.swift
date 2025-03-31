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
    @Injected(\.acceptanceReviewInteractor) private var acceptanceReviewInteractor
    @Injected(\.generalBoardInteractor) private var generalBoardInteractor

    @State private var selection = 0
    @State private var hotAcceptanceReviews: [AcceptanceReview] = []
    @State private var currentHotAcceptanceReviewIndex = 0
    @State private var acceptanceReviewList: [AcceptanceReview] = []

    var body: some View {
        content
            .onAppear(perform: loadInitialState)
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

        Text(hotAcceptanceReviews[safe: currentHotAcceptanceReviewIndex]?.title ?? "없음")

        List {
            ForEach(acceptanceReviewList) { acceptanceReview in
                Text(acceptanceReview.title)
            }
        }

        Spacer()
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

#Preview {
    CommunityView()
}
