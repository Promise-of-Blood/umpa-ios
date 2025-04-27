// Created for Umpa in 2025

import Domain
import SwiftUI

struct TeacherSignUpView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var signUpModel: TeacherSignUpModel

    init(socialLoginType: SocialLoginType) {
        self._signUpModel = StateObject(wrappedValue: TeacherSignUpModel(socialLoginType: socialLoginType))
    }

    var body: some View {
        content
    }

    var content: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TeacherSignUpView(socialLoginType: .apple)
}
