// Created for Umpa in 2025

import Foundation

public struct PhoneNumber: Equatable {
    public var rawNumber: String
    
    public var presentedNumber: String {
        switch rawNumber.count {
            case 11: // 01012345678 → 010‑1234‑5678
                let first = rawNumber.prefix(3)
                let middle = rawNumber.dropFirst(3).prefix(4)
                let last = rawNumber.suffix(4)
                return "\(first)-\(middle)-\(last)"
                   
            case 10: // 02/031 등 두 가지 패턴
                if rawNumber.hasPrefix("02") { // 0212345678 → 02‑1234‑5678
                    let first = rawNumber.prefix(2)
                    let middle = rawNumber.dropFirst(2).prefix(4)
                    let last = rawNumber.suffix(4)
                    return "\(first)-\(middle)-\(last)"
                } else { // 0311234567 → 031‑123‑4567
                    let first = rawNumber.prefix(3)
                    let middle = rawNumber.dropFirst(3).prefix(3)
                    let last = rawNumber.suffix(4)
                    return "\(first)-\(middle)-\(last)"
                }
                   
            case 9: // 02 지역번호 짧은 국번(3) 패턴: 02‑123‑4567
                if rawNumber.hasPrefix("02") {
                    let first = rawNumber.prefix(2)
                    let middle = rawNumber.dropFirst(2).prefix(3)
                    let last = rawNumber.suffix(4)
                    return "\(first)-\(middle)-\(last)"
                }
                fallthrough // 규칙을 모르면 원본 그대로
            default:
                return rawNumber
        }
    }
    
    init() {
        self.rawNumber = ""
    }
    
    /// 지정한 문자열이 올바른 숫자 전화번호인지 검사하여 초기화
    public init(phoneNumber: String) throws {
        try PhoneNumberVerifier(phoneNumber: phoneNumber).verify()
        self.rawNumber = phoneNumber
    }
    
    public static func empty() -> PhoneNumber {
        return PhoneNumber()
    }
    
    public func verify() throws {
        try PhoneNumberVerifier(phoneNumber: rawNumber).verify()
    }
}

private struct PhoneNumberVerifier {
    let phoneNumber: String
    
    func verify() throws {
        // 모든 문자가 숫자인지 확인
        guard phoneNumber.allSatisfy(\.isNumber) else {
            throw DomainError.disallowedValue
        }
        
        // 자리수 제한(대한민국 기준 9~11자리)
        guard (9 ... 11).contains(phoneNumber.count) else {
            throw DomainError.disallowedValue
        }
    }
}
