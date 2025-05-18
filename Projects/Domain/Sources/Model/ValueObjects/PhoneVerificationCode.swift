// Created for Umpa in 2025

import Foundation

public struct PhoneVerificationCode: Hashable {
    public let rawCode: String

    public init?(rawCode: String) {
        guard PhoneVerificationCodeValidator(rawCode: rawCode).validate() else {
            return nil
        }
        self.rawCode = rawCode
    }
}

public struct PhoneVerificationCodeValidator: Validator {
    let rawCode: String

    public init(rawCode: String) {
        self.rawCode = rawCode
    }

    public func validate() -> Bool {
        guard rawCode.allSatisfy(\.isNumber) else {
            return false
        }
        guard rawCode.count == 6 else {
            return false
        }
        return true
    }
}
