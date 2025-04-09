// Created for Umpa in 2025

import Components
import DataAccess
import Factory
import SwiftUI

struct SignUpMajorSelectionView: View {
    @InjectedObject(\.appState) private var appState
    @InjectedObject(\.signUpModel) private var signUpModel

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
            .onAppear {
                if signUpModel.major == nil {
                    signUpModel.major = appState.userData.majorList.first
                }
            }
    }

    var content: some View {
        VStack {
            Text("전공을 선택해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                Picker("Major", selection: $signUpModel.major) {
                    ForEach(appState.userData.majorList, id: \.self) { major in
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
                SignUpDreamCollegesSelectionView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignUpMajorSelectionView()
    }
}
