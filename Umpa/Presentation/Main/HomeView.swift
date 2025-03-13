// Created for Umpa in 2025

import SwiftUI

struct HomeView: View {
    @State private var selection = 0

    var body: some View {
        VStack {
            Image(.umpaLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120)
            teacherFindingCarouselView
        }
    }

    var teacherFindingCarouselView: some View {
        VStack(alignment: .leading) {
            Text("선생님 찾기")
                .font(.system(size: 24))
            CustomDotsCarouselView(selection: $selection, pageCount: 2) {
                Grid {
                    GridRow {
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                    }
                    GridRow {
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                    }
                }
                .tag(0)
                Grid {
                    GridRow {
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                    }
                    GridRow {
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                        Text("")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                    }
                }
                .tag(1)
            }
        }
    }
}

#Preview {
    HomeView()
}
