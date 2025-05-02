// Created for Umpa in 2025

import Foundation

public struct PhoneNumberFormatter {
    let phoneNumber: String

    init(_ phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

    /// 하이픈을 포함한 전화번호 형식으로 변환합니다.
    ///
    /// - 12345678 -> 1234-5678
    public func semiFormatted() -> String {
        let length = phoneNumber.count
        if length <= 4 {
            return phoneNumber
        } else {
            let part1 = phoneNumber.prefix(4)
            let part2 = phoneNumber.dropFirst(4)
            return "\(part1)-\(part2)"
        }
    }

    /// 하이픈을 포함한 전화번호 형식으로 변환합니다.
    ///
    /// - 01012345678 -> 010-1234-5678
    public func fullFormatted() -> String {
        let length = phoneNumber.count
        if length <= 3 {
            return phoneNumber
        } else if length <= 7 {
            let prefix = phoneNumber.prefix(3)
            let suffix = phoneNumber.dropFirst(3)
            return "\(prefix)-\(suffix)"
        } else {
            let part1 = phoneNumber.prefix(3)
            let part2 = phoneNumber.dropFirst(3).prefix(4)
            let part3 = phoneNumber.dropFirst(7)
            return "\(part1)-\(part2)-\(part3)"
        }
    }
}
