// Created for Umpa in 2025

import Components
import SwiftUI

struct DreamCollegesSelectionView: View {
    @ObservedObject var signUpModel: SignUpModel

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
                    InputFieldLabelText("학교 1")
                    // Picker
                }
                VStack {
                    InputFieldLabelText("학교 2")
                    // Picker
                }
                VStack {
                    InputFieldLabelText("학교 3")
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
        DreamCollegesSelectionView(signUpModel: SignUpModel(socialLoginType: .apple))
    }
}
