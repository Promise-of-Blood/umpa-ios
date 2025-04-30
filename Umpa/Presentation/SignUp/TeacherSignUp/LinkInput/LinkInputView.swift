// Created for Umpa in 2025

import SwiftUI

struct LinkInputView: View {
    @ObservedObject var signUpModel: TeacherSignUpModel

    var body: some View {
        content
    }

    var content: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LinkInputView(signUpModel: TeacherSignUpModel(socialLoginType: .apple))
}
