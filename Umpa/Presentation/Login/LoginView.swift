//
//  LoginView.swift
//  Umpa
//
//  Created by 공명선 on 1/10/25.
//

import SwiftUI

enum LoginType {
    case kakao
    case naver
    case google
    case apple
}

struct LoginView: View {
    @State private var path: [LoginType] = []

    var body: some View {
        NavigationStack(path: $path) {
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
                    // FIXME: 개발용 임시 코드
                    .navigationDestination(for: LoginType.self) { _ in
                        SignUpUserTypeSelectionView()
                    }
            }
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
        #if RELEASE
            fatalError()
        #endif
        path.append(.kakao)
    }

    func loginWithNaver() {
        #if RELEASE
            fatalError()
        #endif
        path.append(.naver)
    }

    func loginWithGoogle() {
        #if RELEASE
            fatalError()
        #endif
        path.append(.google)
    }
}

#Preview {
    LoginView()
}

#Preview(traits: .iPhoneSE) {
    LoginView()
}
