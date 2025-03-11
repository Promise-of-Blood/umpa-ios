// Created for Umpa in 2025

import SwiftUI

struct HomeView: View {
    var body: some View {
        Image(.umpaLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
//            .background(Color.gray)
    }
}

#Preview {
    HomeView()
}
