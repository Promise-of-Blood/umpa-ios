// Created for Umpa in 2025

import SwiftUI

struct SignUpChoiceSchoolSelectionView: View {
    var body: some View {
        VStack {
            InputFieldLabelText("지망 학교를 설정해주세요")
        }
        .modifier(BackButton())
    }
}

#Preview {
    SignUpChoiceSchoolSelectionView()
}
