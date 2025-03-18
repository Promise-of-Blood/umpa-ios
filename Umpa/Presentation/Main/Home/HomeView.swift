// Created for Umpa in 2025

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image(.umpaLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                TeacherFindingSection()
                Spacer()
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
                    }
                }
                .frame(width: .fill, height: 260) // TODO: Temp height
                DotsPagination(
                    currentIndex: $currentIndex,
                    pageCount: pageCount,
                    appearance: .default
                )
            }
        }
        .padding(.horizontal, 28)
    }
}

private struct TeacherFindingCarouselItem: View {
    let imageResource: ImageResource
    let caption: String

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 5) {
                Image(imageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .background(UmpaColor.lightBlue, in: RoundedRectangle(cornerRadius: 15))
                Text(caption)
                    .font(UmpaFont.captionKr)
                    .foregroundStyle(UmpaColor.darkGray)
            }
            .frame(minWidth: 52)
        }
//        .frame(minHeight: 30)
    }
}

private struct Banner: View {
    let count = 3
    @State var currentIndex: Int = 1

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Carousel(currentIndex: $currentIndex) {
                Color.red
                    .tag(0)
                Color.blue
                    .tag(1)
                Color.green
                    .tag(2)
            }
            .frame(height: 80)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("\(currentIndex + 1)/\(count)")
                .font(.system(size: 10, weight: .medium))
                .frame(width: 32, height: 12)
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: 20))
                .offset(x: -16, y: -8)
        }
        .padding(.horizontal, 30)
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

private struct SeeAllButton: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 7) {
                Text("전체보기")
                    .font(.pretendardMedium(size: 10))
                Image(.customChevronRight)
                    .frame(width: 6, height: 9)
            }
            .foregroundStyle(Color(hex: "72727C"))
        }
    }
}

private struct ReviewCard: View {
    var body: some View {
        VStack {
            Text("리뷰")
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
