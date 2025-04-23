// Created for Umpa in 2025

import Foundation

public struct PhoneNumber: Equatable {
    public let rawNumber: String
    
    init() {
        self.rawNumber = ""
    }
    
    /// 지정한 문자열이 올바른 숫자 전화번호인지 검사하여 초기화
    public init?(phoneNumber: String) {
        guard PhoneNumberValidator(rawPhoneNumber: phoneNumber).validate() else {
            return nil
        }
        self.rawNumber = phoneNumber
    }
    
    public static func empty() -> PhoneNumber {
        return PhoneNumber()
    }
}

public struct PhoneNumberValidator: Validator {
    let rawPhoneNumber: String
    
    public init(rawPhoneNumber: String) {
        self.rawPhoneNumber = rawPhoneNumber
    }
    
    public func validate() -> Bool {
        // 모든 문자가 숫자인지 확인
        guard rawPhoneNumber.allSatisfy(\.isNumber) else {
            return false
        }
        
        // 자리수 제한
        guard rawPhoneNumber.count == 11 else {
            return false
        }
        
        return true
    }
}
