// Created for Umpa in 2025

@testable import Domain
import Testing

@Suite(.tags(.domain))
struct PhoneNumberTests {
    @Test("규칙에 맞지 않는 값이 들어올 때 실패 확인", arguments: [
        "010-1234-5678", // 하이픈 포함
        "abcd",
        "1234abcd",
        "0101234567", // 10자리
        "010123456789", // 12자리
        "03112345678", // 010이 아닌 번호
    ])
    func invalidPhoneNumber(phoneNumber: String) {
        #expect(PhoneNumber(phoneNumber: phoneNumber) == nil)
    }

    @Test("유효한 11자리 핸드폰 번호 문자열이 들어올 때", arguments: [
        "01012345678",
    ])
    func validPhoneNumber(phoneNumber: String) {
        #expect(PhoneNumber(phoneNumber: phoneNumber) != nil)
    }
}
