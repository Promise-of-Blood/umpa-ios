// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

private let contentHorizontalPadding: CGFloat = fs(28)

struct HomeView: View {
    @State private var isPresentingMyProfile = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .bottomTrailing) {
                    ScrollView {
                        VStack(spacing: fs(34)) {
                            header
                            content
                        }
                        .frame(width: geometry.size.width)
                        .padding(.vertical, fs(20))
                    }
                    .padding(.top, 1) // 네비게이션 바 유지를 위함
                    calendarButton
                        .offset(x: fs(-28), y: fs(-25))
                }
            }
        }
    }

    var header: some View {
        HStack(alignment: .bottom) {
            Image(.umpaLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: fs(87))
            Spacer()
            HStack(spacing: fs(12)) {
                Button(action: {
                    // TODO: Implement
                }) {
                    Image(.notificationIcon)
                }
                Button(action: {
                    isPresentingMyProfile.toggle()
                }) {
                    Image(.profileIcon)
                        .fullScreenCover(isPresented: $isPresentingMyProfile) {
                            MyProfileView()
                        }
                }
            }
        }
        .padding(.horizontal, contentHorizontalPadding)
    }

    var content: some View {
        VStack(spacing: fs(30)) {
            TeacherFindingSection()
            Banner(bannerResources: [
                .bannerSample1,
                .bannerSample1,
                .bannerSample1,
            ])
            .padding(.horizontal, contentHorizontalPadding)
            CommunitySection()
        }
    }

    var calendarButton: some View {
        Button(action: {
            // TODO: Implement
        }) {
            ZStack {
                Circle()
                    .frame(width: fs(50), height: fs(50))
                    .foregroundStyle(UmpaColor.blueMain)
                Image(.calendarIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color(hex: "EFEFEF"))
                    .frame(width: fs(32), height: fs(29))
            }
        }
    }
}

private struct TeacherFindingSection: View {
    @InjectedObject(\.mainViewModel) private var mainViewModel

    @State private var currentIndex = 0

    private let gridRowCount = 2
    private let gridColumnCount = 5

    private var itemsPerPage: Int { gridRowCount * gridColumnCount }

    private var pageCount: Int {
        let shortcutCount = Subject.allCases.count + 1 // 전체보기 버튼 +1
        return Int(ceil(Double(shortcutCount) / Double(itemsPerPage)))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: fs(15)) {
            Text("선생님 찾기")
                .font(UmpaFont.h2Kr)
                .padding(.horizontal, contentHorizontalPadding)
            VStack(spacing: fs(12)) {
                carouselContent
                DotsPagination(
                    currentIndex: $currentIndex,
                    pageCount: pageCount,
                    appearance: .default
                )
            }
        }
    }

    var carouselContent: some View {
        Carousel(currentIndex: $currentIndex) {
            ForEach(0..<pageCount, id: \.self) { page in
                Grid(alignment: .top, horizontalSpacing: fs(12), verticalSpacing: fs(20)) {
                    ForEach(0..<gridRowCount, id: \.self) { row in
                        GridRow {
                            ForEach(0..<gridColumnCount, id: \.self) { column in
                                let index = page * itemsPerPage + row * gridColumnCount + column
                                if index == 0 {
                                    TeacherFindingCarouselItem(
                                        imageResource: ImageResource(name: "", bundle: .main),
                                        caption: "전체보기"
                                    )
                                } else if let subject = Subject.allCases[safe: index - 1] {
                                    Button {
                                        mainViewModel.currentTabIndex = 1
                                        mainViewModel.selectedSubject = subject.name
                                    } label: {
                                        TeacherFindingCarouselItem(
                                            imageResource: ImageResource(name: "", bundle: .main),
                                            caption: subject.name
                                        )
                                    }
                                } else {
                                    TeacherFindingCarouselItem(
                                        imageResource: ImageResource(name: "", bundle: .main),
                                        caption: ""
                                    )
                                    .hidden()
                                }
                            }
                        }
                    }
                }
                .tag(page)
                .padding(.horizontal, contentHorizontalPadding)
            }
        }
        // FIXME: 임시 높이, TabView를 사용하지 않는 Carousel 구현으로 해결 필요
        .frame(height: fs(160))
    }
}

private struct CommunitySection: View {
    @Injected(\.acceptanceReviewInteractor) private var acceptanceReviewInteractor

    var body: some View {
        content
    }

    var content: some View {
        VStack(spacing: fs(14)) {
            Text("음파 커뮤니티")
                .font(UmpaFont.h2Kr)
                .foregroundStyle(Color(hex: "121214"))
                .frame(maxWidth: .fill, alignment: .leading)
                .padding(.horizontal, contentHorizontalPadding)
            VStack(spacing: fs(16)) {
                acceptanceReviewsRow
                informationSharingRow
                LatestQuestionsRow()
                mentoringRow
            }
        }
        .frame(maxWidth: .fill)
    }

    var acceptanceReviewsRow: some View {
        VStack(spacing: fs(10)) {
            HStack {
                Text("지금 인기있는 합격 후기")
                    .foregroundStyle(UmpaColor.darkGray)
                    .font(UmpaFont.h3Kr)
                Spacer()
                SeeAllButton()
            }
            .padding(.horizontal, contentHorizontalPadding)
            .frame(maxWidth: .fill)
            ScrollView(.horizontal) {
                HStack {
                    Spacer(minLength: contentHorizontalPadding)
                    HStack(spacing: fs(5)) {
                        Card(model: .sample1)
                        Card(model: .sample1)
                        Card(model: .sample1)
                        Card(model: .sample1)
                    }
                    Spacer(minLength: contentHorizontalPadding)
                }
            }
            .scrollIndicators(.never)
        }
    }

    var informationSharingRow: some View {
        VStack(spacing: fs(10)) {
            HStack {
                Text("방금 올라온 정보 공유")
                    .foregroundStyle(UmpaColor.darkGray)
                    .font(UmpaFont.h3Kr)
                Spacer()
                SeeAllButton()
            }
            VStack(spacing: fs(9)) {
                ListContent(model: .sample1)
                HorizontalDivider(thickness: fs(1.25), color: .white)
                ListContent(model: .sample1)
                HorizontalDivider(thickness: fs(1.25), color: .white)
                ListContent(model: .sample1)
            }
            .padding(.horizontal, fs(15))
            .padding(.vertical, fs(14))
            .background(UmpaColor.baseColor, in: RoundedRectangle(cornerRadius: fs(15)))
        }
        .padding(.horizontal, contentHorizontalPadding)
    }

    var mentoringRow: some View {
        VStack(spacing: fs(10)) {
            HStack {
                Text("방금 등록된 멘토링 글")
                    .foregroundStyle(UmpaColor.darkGray)
                    .font(UmpaFont.h3Kr)
                Spacer()
                SeeAllButton()
            }
            .padding(.horizontal, contentHorizontalPadding)
            .frame(maxWidth: .fill)
            ScrollView(.horizontal) {
                HStack {
                    Spacer(minLength: contentHorizontalPadding)
                    HStack(spacing: fs(5)) {
                        Card(model: .sample1)
                        Card(model: .sample1)
                        Card(model: .sample1)
                        Card(model: .sample1)
                    }
                    Spacer(minLength: contentHorizontalPadding)
                }
            }
            .scrollIndicators(.never)
        }
    }
}

private struct LatestQuestionsRow: View {
    @Injected(\.questionInteractor) private var questionInteractor

    @State private var questions: [Question] = []

    var body: some View {
        content
            .onAppear {
                Task {
                    try? await questionInteractor.load($questions)
                }
            }
    }

    var content: some View {
        VStack(spacing: fs(10)) {
            HStack {
                Text("가장 최근에 올라온 질문")
                    .foregroundStyle(UmpaColor.darkGray)
                    .font(UmpaFont.h3Kr)
                Spacer()
                SeeAllButton()
            }
            VStack(spacing: fs(9)) {
                IndexingForEach(questions) { index, question in
                    NavigationLink {
                        QuestionDetailView(question: question)
                    } label: {
                        ListContent(model: question.toListContentModel())
                    }
                    if index < questions.count - 1 {
                        HorizontalDivider(thickness: fs(1.25), color: .white)
                    }
                }
            }
            .padding(.horizontal, fs(15))
            .padding(.vertical, fs(14))
            .background(UmpaColor.baseColor, in: RoundedRectangle(cornerRadius: fs(15)))
        }
        .padding(.horizontal, contentHorizontalPadding)
    }
}

#Preview {
    Container.shared.questionInteractor.register { MockQuestionInteractor() }

    return TabView {
        HomeView()
            .tabItem {
                TabLabel(category: .home)
            }
            .tag(0)
        Color.blue
            .tabItem {
                TabLabel(category: .matching)
            }
            .tag(1)
        Color.yellow
            .tabItem {
                TabLabel(category: .community)
            }
            .tag(2)
        Color.red
            .tabItem {
                TabLabel(category: .chatting)
            }
            .tag(3)
    }
}

#Preview("iPhoneSE", traits: .iPhoneSE) {
    Container.shared.questionInteractor.register { MockQuestionInteractor() }

    return TabView {
        HomeView()
            .tabItem {
                TabLabel(category: .home)
            }
            .tag(0)
        Color.blue
            .tabItem {
                TabLabel(category: .matching)
            }
            .tag(1)
        Color.yellow
            .tabItem {
                TabLabel(category: .community)
            }
            .tag(2)
        Color.red
            .tabItem {
                TabLabel(category: .chatting)
            }
            .tag(3)
    }
}
