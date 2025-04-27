// Created for Umpa in 2025

import Components
import SwiftUI

struct DreamCollegesSelectionView: View {
    @ObservedObject var studentSignUpModel: StudentSignUpModel

    var body: some View {
        content
            .modifier(NavigationBackButton(.arrowBack))
    }

    var content: some View {
        VStack {
            Text("지망 학교를 설정해주세요")
                .modifier(TitleText())
            Spacer()
            InputContentVStack(spacing: 10) {
                VStack {
                    // Picker
                }
                VStack {
                    // Picker
                }
                VStack {
                    // Picker
                }
            }
            Spacer()
            NavigationLink {
//                SignUpFinishView(signUpModel: signUpModel)
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
    }
}

#Preview {
    NavigationStack {
        DreamCollegesSelectionView(studentSignUpModel: StudentSignUpModel(socialLoginType: .apple))
    }
}
