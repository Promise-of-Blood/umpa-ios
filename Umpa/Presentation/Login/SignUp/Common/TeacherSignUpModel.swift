// Created for Umpa in 2025

import Domain
import SwiftUI

final class TeacherSignUpModel: ObservableObject {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var major: String?

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }
}
