// Created for Umpa in 2025

import Factory
import SwiftUI

struct CommunityView: View {
    @Injected(\.acceptanceReviewInteractor) private var acceptanceReviewInteractor
    @Injected(\.generalBoardInteractor) private var generalBoardInteractor

    var body: some View {
        Text("Community")
    }
}

#Preview {
    CommunityView()
}
