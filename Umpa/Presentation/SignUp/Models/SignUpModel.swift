// Created for Umpa in 2025

import Domain
import SwiftUI

@available(*, deprecated,
           message: "기획/구현 변경으로 인해 삭제 예정 : `StudentSignUpModel` or `TeacherSignUpModel`을 대신 사용하세요.")
final class SignUpModel: ObservableObject {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var userType: UserType?
    @Published var major: String?
    @Published var dreamCollege1: String?
    @Published var dreamCollege2: String?
    @Published var dreamCollege3: String?

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }
}
