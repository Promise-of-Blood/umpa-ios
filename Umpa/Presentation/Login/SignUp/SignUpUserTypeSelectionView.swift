// Created for Umpa in 2025

import SwiftUI

struct SignUpUserTypeSelectionView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isStudent = false

    var body: some View {
        VStack {
            Text("앱의 이용 목적에 따라\n선택해주세요")
                .modifier(TitleText())
            Spacer()
            HStack {
                Button("학생 회원") {
                    //
                }
                Button("선생님 회원") {
                    //
                }
            }
            Spacer()
            NavigationLink {
                if isStudent {
                    SignUpNicknameInputView()
                } else {
                    SignUpNameInputView()
                }
            } label: {
                Text("다음")
                    .modifier(BottomButton())
            }
        }
        .modifier(BackButton())
    }
}

#Preview {
    NavigationStack {
        SignUpUserTypeSelectionView()
    }
}

#Preview(traits: .iPhoneSE) {
    NavigationStack {
        SignUpUserTypeSelectionView()
    }
}
