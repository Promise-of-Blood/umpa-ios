// Created for Umpa in 2025

import Components
import SwiftUI

struct SignUpChoiceSchoolSelectionView: View {
    var body: some View {
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
                SignUpFinishView()
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(NavigationBackButton(.arrowBack))
    }
}

#Preview {
    NavigationStack {
        SignUpChoiceSchoolSelectionView()
    }
}
