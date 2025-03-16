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
                TeacherFindingCarousel()
                Spacer()
                Banner()
                ComunitySection()
            }
        }
    }
}

private struct TeacherFindingCarousel: View {
    @State private var currentIndex = 0

    private var gridRowCount = 2
    private var gridColumnCount = 5

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
        "화성학",
        "보컬",
        "샘플1",
        "샘플2",
        "샘플3",
        "샘플4",
        "샘플5",
        "샘플6",
        "샘플7",
    ]

    private var pageCount: Int {
        Int(ceil(Double(list.count) / Double(itemsPerPage)))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("선생님 찾기")
                .font(.system(size: 24))
                .padding(.leading, 40)
            PaginationCarousel(currentIndex: $currentIndex, pageCount: pageCount) {
                ForEach(0..<pageCount, id: \.self) { page in
                    Grid {
                        ForEach(0..<gridRowCount, id: \.self) { row in
                            GridRow {
                                ForEach(0..<gridColumnCount, id: \.self) { column in
                                    let index = page * itemsPerPage + row * gridColumnCount + column
                                    if let i = list[safe: index] {
                                        TeacherFindingCarouselItem(
                                            imageResource: ImageResource(name: "", bundle: .main),
                                            caption: i
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .tag(page)
                }
            }
            .frame(width: .infinity, height: 240)
        }
    }
}

struct TeacherFindingCarouselItem: View {
    let imageResource: ImageResource
    let caption: String

    var body: some View {
        VStack(spacing: 5) {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 34, height: 34)
                .padding(8)
                .background(Color(hex: "#D6E1FF"), in: RoundedRectangle(cornerRadius: 15))
            Text(caption)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color(hex: "#AFAFB4"))
        }
    }
}

struct Banner: View {
    let count = 3
    @State var currentIndex: Int = 1

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Carousel(selection: $currentIndex) {
                Color.red
                    .tag(0)
                Color.blue
                    .tag(1)
                Color.green
                    .tag(2)
            }
            .frame(width: 300, height: 80)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("\(currentIndex + 1)/\(count)")
                .font(.system(size: 10, weight: .medium))
                .frame(width: 32, height: 12)
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: 20))
                .offset(x: -16, y: -8)
        }
    }
}

struct ComunitySection: View {
    var body: some View {
        VStack {
            Text("음파 커뮤니티")
                .font(.pretendardBold(size: 20))
        }
    }
}

#Preview {
    HomeView()
}

#Preview(traits: .iPhoneSE) {
    HomeView()
}
