// Created for Umpa in 2025

import SwiftUI

class SignUpModel: ObservableObject {
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var userType: UserType = .student
    @Published var major: String?
    @Published var wantedCollege1: String?
    @Published var wantedCollege2: String?
    @Published var wantedCollege3: String?
}
