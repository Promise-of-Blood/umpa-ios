// Created for Umpa in 2025

import Components
import Factory
import SwiftUI

struct StudentMajorSelectionView: View {
    @InjectedObject(\.appState) private var appState

    @ObservedObject var studentSignUpModel: StudentSignUpModel
    @Binding var isSatisfiedToNextStep: Bool

    // MARK: View

    var body: some View {
        content
            .onAppear {
                if studentSignUpModel.major == nil {
                    studentSignUpModel.major = appState.userData.majorList.first
                }
                isSatisfiedToNextStep = studentSignUpModel.validateMajor()
            }
            .onChange(of: studentSignUpModel.major) {
                isSatisfiedToNextStep = studentSignUpModel.validateMajor()
            }
    }

    var content: some View {
        VStack {
            Text("전공을 선택해주세요")
                .modifier(TitleText())
            Text(studentSignUpModel.major ?? "error")
            Spacer()
            InputContentVStack {
                Picker("Major", selection: $studentSignUpModel.major) {
                    ForEach(appState.userData.majorList, id: \.self) { major in
                        Text(major).tag(major)
                    }
                }
            }
        }
    }
}

#Preview {
    StudentMajorSelectionView(
        studentSignUpModel: StudentSignUpModel(socialLoginType: .apple),
        isSatisfiedToNextStep: .constant(false)
    )
}
