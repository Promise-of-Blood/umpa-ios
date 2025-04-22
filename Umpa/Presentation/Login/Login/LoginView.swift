//
//  LoginView.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import AuthenticationServices
import Domain
import Factory
import SwiftUI

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
            VStack(spacing: fs(10)) {
                Text("당신의 음악 파트너")
                    .font(.pretendardBold(size: fs(20)))
                    .foregroundStyle(Color.white)
                    .padding(.top, fs(230))
                Image(.umpaLogo)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: fs(200))
                    .foregroundStyle(.white)
            }
            Spacer()
            VStack(spacing: fs(20)) {
                Text("소셜계정으로 바로 시작하기")
                    .font(.pretendardSemiBold(size: fs(16)))
                    .foregroundStyle(.white)
                loginButtons
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(UmpaColor.mainBlue)
    }

    var loginButtons: some View {
        HStack(spacing: fs(4)) {
            Button(action: loginInteractor.loginWithKakao) {
                Image(.kakaoLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: loginInteractor.loginWithNaver) {
                Image(.naverLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: loginInteractor.loginWithGoogle) {
                Image(.googleLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {
                loginInteractor.loginWithApple(with: authorizationController)
            }) {
                Image(.appleLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(maxWidth: .infinity, idealHeight: fs(60))
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, fs(46))
        .padding(.bottom, fs(132))
    }
}

#Preview {
    LoginView()
}

#Preview(traits: .iPhoneSE) {
    LoginView()
}
