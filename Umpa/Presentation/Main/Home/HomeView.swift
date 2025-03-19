// Created for Umpa in 2025

import SwiftUI
import UmpaComponents

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image(.umpaLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                TeacherFindingSection()
                Banner()
                CommunitySection()
                SeeAllButton()
            }
        }
    }
}

private struct TeacherFindingSection: View {
    @State private var currentIndex = 0

    private let gridRowCount = 2
    private let gridColumnCount = 5

    private var itemsPerPage: Int { gridRowCount * gridColumnCount }

    private let list: [String] = [
        "전체보기",
        "피아노",
        "보컬",
        "작곡",
        "드럼",
        "기타",
        "베이스",
        "관악",
        "전자음악",
        "전통화성학",
        "실용화성학",
        "시창청음",
        "악보제작",
        "반주자",
        "MR제작",
    ]

    private var pageCount: Int {
        Int(ceil(Double(list.count) / Double(itemsPerPage)))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("선생님 찾기")
                .font(UmpaFont.h2Kr)
            VStack(spacing: 12) {
                Carousel(currentIndex: $currentIndex) {
                    ForEach(0..<pageCount, id: \.self) { page in
                        Grid(alignment: .top, horizontalSpacing: 12, verticalSpacing: 20) {
                            ForEach(0..<gridRowCount, id: \.self) { row in
                                GridRow {
                                    ForEach(0..<gridColumnCount, id: \.self) { column in
                                        let index = page * itemsPerPage + row * gridColumnCount + column
                                        if let caption = list[safe: index] {
                                            TeacherFindingCarouselItem(
                                                imageResource: ImageResource(name: "", bundle: .main),
                                                caption: caption
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .tag(page)
                        .padding(.horizontal, 28)
                    }
                }
                // FIXME: 임시 높이, TabView를 사용하지 않는 Carousel 구현으로 해결 필요
                .frame(height: 180)
                DotsPagination(
                    currentIndex: $currentIndex,
                    pageCount: pageCount,
                    appearance: .default
                )
            }
        }
    }
}

private struct CommunitySection: View {
    var body: some View {
        VStack {
            Text("음파 커뮤니티")
                .font(.pretendardBold(size: 20))
        }
    }
}

#Preview {
    TabView {
        HomeView()
            .tabItem {
                TabLabel(category: .home)
            }
    }
}

#Preview(traits: .iPhoneSE) {
    HomeView()
}
