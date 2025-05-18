// Created for Umpa in 2025

import AuthenticationServices
import BaseFeature
import Domain
import Factory
import SwiftUI
import UmpaUIKit

/// 학생 또는 선생님 회원가입을 진행하기 전에 공통으로 필요한 데이터.
final class PreSignUpData: ObservableObject {
  var socialLoginType: SocialLoginType?
  @Published var userType: UserType?
}

struct LoginView: View {
  enum NavigationDestination {
    case phoneNumberInput
  }

  @Environment(\.authorizationController) private var authorizationController
  @Environment(AppState.self) private var appState

#if DEBUG
  @Injected(\.mockLoginInteractor)
#else
  @Injected(\.loginInteractor)
#endif
  private var loginInteractor

  @StateObject private var preSignUpData = PreSignUpData()

  @State private var isTappedAnyLoginButton = false

  private let socialLoginButtonSize: CGFloat = fs(60)

  var body: some View {
    @Bindable var appState = appState
    NavigationStack(path: $appState.routing.loginNavigationPath) {
      content
        .navigationDestination(for: NavigationDestination.self) {
          // 본인인증 진행
          if case .phoneNumberInput = $0, preSignUpData.socialLoginType != nil {
            PhoneVerificationView()
          }
        }
    }
    .environmentObject(preSignUpData)
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
        loginInteractor.loginWithKakao(
          isTappedAnyLoginButton: $isTappedAnyLoginButton,
          socialLoginType: $preSignUpData.socialLoginType
        )
      }) {
        Image(.kakaoLoginIconCircle)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .disabled(isTappedAnyLoginButton)
      .accessibilityLabel("카카오 로그인")
      Spacer()
      Button(action: {
        loginInteractor.loginWithNaver(
          isTappedAnyLoginButton: $isTappedAnyLoginButton,
          socialLoginType: $preSignUpData.socialLoginType
        )
      }) {
        Image(.naverLoginIconCircle)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .disabled(isTappedAnyLoginButton)
      .accessibilityLabel("네이버 로그인")
      Spacer()
      Button(action: {
        loginInteractor.loginWithGoogle(
          isTappedAnyLoginButton: $isTappedAnyLoginButton,
          socialLoginType: $preSignUpData.socialLoginType
        )
      }) {
        Image(.googleLoginIconCircle)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .disabled(isTappedAnyLoginButton)
      .accessibilityLabel("구글 로그인")
      Spacer()
      Button(action: {
        loginInteractor.loginWithApple(
          with: authorizationController,
          isTappedAnyLoginButton: $isTappedAnyLoginButton,
          socialLoginType: $preSignUpData.socialLoginType,
        )
      }) {
        Image(.appleLoginIconCircle)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .disabled(isTappedAnyLoginButton)
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
