//
//  LoginView.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import AuthenticationServices
import Factory
import SwiftUI

enum SocialLoginType {
    case kakao
    case naver
    case google
    case apple
}

struct LoginView: View {
    @Environment(\.authorizationController) private var authorizationController
    @InjectedObject(\.appState) private var appState
    @Injected(\.loginInteractor) private var loginInteractor

    var body: some View {
        NavigationStack(path: $appState.routing.loginNavigationPath) {
            content
                .navigationDestination(for: SocialLoginType.self) { socialLoginType in
                    SignUpUserTypeSelectionView(socialLoginType: socialLoginType)
                }
        }
    }

    @ViewBuilder
    var content: some View {
        VStack {
            Image(.umpaLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 240)
                .padding(.top, 120)
            Text("당신의 음악 파트너")
                .font(.system(size: 22))
                .foregroundStyle(UmpaColor.lightGray)
                .padding(10)
            Spacer()
            loginButtons
        }
    }

    var loginButtons: some View {
        VStack(spacing: 10) {
            Button(action: loginWithKakao) {
                Image(.kakaoLogin)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button(action: loginWithNaver) {
                Image(.naverLogin)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button(action: loginWithGoogle) {
                Image(.googleLogin)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }

    func loginWithKakao() {
        loginInteractor.loginWithKakao()
    }

    func loginWithNaver() {
        loginInteractor.loginWithNaver()
    }

    func loginWithGoogle() {
        loginInteractor.loginWithGoogle()
    }
}

#Preview {
    LoginView()
}

#Preview(traits: .iPhoneSE) {
    LoginView()
}
