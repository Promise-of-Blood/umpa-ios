// Created for Umpa in 2025

import Components
import Networking
import SwiftUI

struct SignUpMajorSelectionView: View {
    @EnvironmentObject var appState: AppState

    @State private var selectedMajor: String?

    var body: some View {
        VStack {
            Text("전공을 선택해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                Picker("Major", selection: $selectedMajor) {
                    ForEach(appState.majorList, id: \.self) { major in
                        Text(major).tag(major)
                    }
                }
            }
            Spacer()
            NavigationLink {
//                if (currentModel.isStudent) {
//                    SignUpChoiceSchoolSelectionView()
//                } else {
//                    SignUpFinishView()
//                }
                SignUpChoiceSchoolSelectionView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(NavigationBackButton(.arrowBack))
        .onAppear {
            selectedMajor = appState.majorList.first
        }
    }
}

#Preview {
    NavigationStack {
        SignUpMajorSelectionView()
    }
}
