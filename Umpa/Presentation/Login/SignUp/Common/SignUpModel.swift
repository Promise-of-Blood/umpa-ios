// Created for Umpa in 2025

import Domain
import SwiftUI

final class SignUpModel: ObservableObject {
    let socialLoginType: SocialLoginType
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var userType: UserType?
    @Published var major: String?
    @Published var wantedCollege1: String?
    @Published var wantedCollege2: String?
    @Published var wantedCollege3: String?

    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
    }
}
