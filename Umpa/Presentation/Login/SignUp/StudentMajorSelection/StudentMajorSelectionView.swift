// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct StudentMajorSelection: View {
    @InjectedObject(\.appState) private var appState

    @ObservedObject var studentSignUpModel: StudentSignUpModel

    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    DismissButton(.arrowBack)
                        .padding(.horizontal, SignUpSharedUIConstant.backButtonPadding)
                }
            }
            .onAppear {
                if studentSignUpModel.major == nil {
                    studentSignUpModel.major = appState.userData.majorList.first
                }
            }
    }

    var content: some View {
        VStack {
            Text("전공을 선택해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack {
                Picker("Major", selection: $studentSignUpModel.major) {
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
//                DreamCollegesSelectionView(studentSignUpModel: studentSignUpModel)
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
    }
}

#Preview {
    NavigationStack {
//        StudentMajorSelection(studentSignUpModel: SignUpModel(socialLoginType: .apple))
    }
}
