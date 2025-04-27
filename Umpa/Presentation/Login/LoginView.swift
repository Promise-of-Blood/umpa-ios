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
    #if DEBUG
    @Injected(\.mockLoginInteractor)
    #else
    @Injected(\.loginInteractor)
    #endif
    private var loginInteractor

    // 회원가입 시 다음 화면에 전달하는 용도로 사용되는 상태 변수
    @State private var socialLoginType: SocialLoginType?

    private let socialLoginButtonSize: CGFloat = fs(60)

    var body: some View {
        NavigationStack(path: $appState.routing.loginNavigationPath) {
            content
                .navigationDestination(for: SignUpRoute.self) { route in
                    // 본인인증 진행
                    if case .phoneNumberVerification = route, let socialLoginType {
                        PhoneVerificationView(socialLoginType: socialLoginType)
                    }
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
            Button(action: {
                loginInteractor.loginWithKakao(socialLoginType: $socialLoginType)
            }) {
                Image(.kakaoLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .accessibilityLabel("카카오 로그인")
            Spacer()
            Button(action: {
                loginInteractor.loginWithNaver(socialLoginType: $socialLoginType)
            }) {
                Image(.naverLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .accessibilityLabel("네이버 로그인")
            Spacer()
            Button(action: {
                loginInteractor.loginWithGoogle(socialLoginType: $socialLoginType)
            }) {
                Image(.googleLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .accessibilityLabel("구글 로그인")
            Spacer()
            Button(action: {
                loginInteractor.loginWithApple(with: authorizationController, socialLoginType: $socialLoginType)
            }) {
                Image(.appleLoginIconCircle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .accessibilityLabel("애플 로그인")
        }
        .frame(maxWidth: .infinity, idealHeight: socialLoginButtonSize)
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
