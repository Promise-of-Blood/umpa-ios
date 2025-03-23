// Created for Umpa in 2025

import SwiftUI

struct SignUpFinishView: View {
    @EnvironmentObject var appState: AppState
//    private var interactor: SignUpInteractor

    var body: some View {
        VStack {
            Text("환영합니다")
                .modifier(TitleText())
            Spacer()
            Button(action: completeSignUp) {
                Text("회원 가입 완료")
                    .modifier(BottomButton())
            }
        }
        .navigationBarBackButtonHidden()
    }

    func completeSignUp() {
        // let userInfo =
        // let result = await interactor.signUp(with: userInfo)
        // if result ... {
        //     appState.isLoggedIn = true
        appState.isLoggedIn = true
    }
}

#Preview {
    SignUpFinishView()
}
