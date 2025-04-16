// Created for Umpa in 2025

import Components
import Domain
import Factory
import SwiftUI

private let contentHorizontalPadding: CGFloat = fs(28)

struct TeacherHomeView: View {
    @State private var isPresentingMyProfile = false

    var body: some View {
        NavigationStack {
            content
        }
    }

    var content: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(spacing: fs(34)) {
                    header
                    homeContent
                }
                .frame(maxWidth: .fill)
                .padding(.vertical, fs(20))
            }
            .padding(.top, 1) // 네비게이션 바 유지를 위함
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

    var homeContent: some View {
        VStack(spacing: fs(30)) {
            TeacherFindingSection()
            Banner(bannerResources: [
                .bannerSample1,
                .bannerSample1,
                .bannerSample1,
            ])
            .padding(.horizontal, contentHorizontalPadding)
        }
    }
}

private struct TeacherFindingSection: View {
    @InjectedObject(\.appState) private var appState

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
                                    Button {
                                        appState.routing.currentTab = .teacherFinder
                                        appState.userData.teacherFinder.selectedService = .lesson
                                        appState.userData.teacherFinder.selectedSubject = nil
                                    } label: {
                                        TeacherFindingCarouselItem(
                                            imageResource: ImageResource(name: "", bundle: .main),
                                            caption: "전체보기"
                                        )
                                    }
                                } else if let subject = Subject.allCases[safe: index - 1] {
                                    Button {
                                        appState.routing.currentTab = .teacherFinder
                                        appState.userData.teacherFinder.selectedService = .lesson
                                        appState.userData.teacherFinder.selectedSubject = subject
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

#Preview {
    TabView {
        TeacherHomeView()
            .tabItem {
                MainTabView.TabLabel(category: .teacherHome)
            }
            .tag(0)
        Color.blue
            .tabItem {
                MainTabView.TabLabel(category: .teacherFinder)
            }
            .tag(1)
        Color.yellow
            .tabItem {
                MainTabView.TabLabel(category: .community)
            }
            .tag(2)
        Color.red
            .tabItem {
                MainTabView.TabLabel(category: .chat)
            }
            .tag(3)
    }
}

#Preview("iPhoneSE", traits: .iPhoneSE) {
    TabView {
        TeacherHomeView()
            .tabItem {
                MainTabView.TabLabel(category: .teacherHome)
            }
            .tag(0)
        Color.blue
            .tabItem {
                MainTabView.TabLabel(category: .teacherFinder)
            }
            .tag(1)
        Color.yellow
            .tabItem {
                MainTabView.TabLabel(category: .community)
            }
            .tag(2)
        Color.red
            .tabItem {
                MainTabView.TabLabel(category: .chat)
            }
            .tag(3)
    }
}
