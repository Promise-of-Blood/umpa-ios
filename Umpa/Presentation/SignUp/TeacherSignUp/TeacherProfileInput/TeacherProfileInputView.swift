// Created for Umpa in 2025

import Core
import SwiftUI

struct TeacherProfileInputView: View {
    @ObservedObject var signUpModel: TeacherSignUpModel
    @Binding var isSatisfiedToNextStep: Bool

    var body: some View {
        content
    }

    var content: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TeacherProfileInputView(
        signUpModel: TeacherSignUpModel(socialLoginType: .apple),
        isSatisfiedToNextStep: .constant(false)
    )
}
