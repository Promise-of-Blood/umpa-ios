// Created for Umpa in 2025

import Factory
import SwiftUI

struct SignUpFinishView: View {
    @InjectedObject(\.appState) private var appState
    @Injected(\.signUpInteractor) private var signUpInteractor
    @Injected(\.signUpModel) private var signUpModel

    var body: some View {
        content
            .navigationBarBackButtonHidden()
    }

    var content: some View {
        VStack {
            Text("환영합니다")
                .modifier(TitleText())
            Spacer()
            Button(action: {
                Task {
                    await signUpInteractor.signUp(with: signUpModel)
                }
            }) {
                Text("회원 가입 완료")
                    .modifier(BottomButton())
            }
        }
    }
}

#Preview {
    SignUpFinishView()
}
