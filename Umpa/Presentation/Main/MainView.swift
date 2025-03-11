// Created for Umpa in 2025

import SwiftUI

struct MainView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("홈")
                }
                .tag(0)
            MatchingView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("매칭서비스")
                }
                .tag(1)
            CommunityView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("커뮤니티")
                }
                .tag(2)
            ChattingView()
                .tabItem {
                    Image(systemName: "4.square.fill")
                    Text("채팅")
                }
                .tag(3)
            MyProfileView()
                .tabItem {
                    Image(systemName: "5.square.fill")
                    Text("내 정보")
                }
                .tag(4)
        }
    }
}

#Preview {
    MainView()
}
