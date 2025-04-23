// Created for Umpa in 2025

@testable import Domain
import Testing

@Suite(.tags(.domain))
struct PhoneNumberTests {
    @Test("하이픈이 포함된 문자열 등 숫자가 아닌 문자가 들어올 때", arguments: [
        "010-1234-5678",
        "abcd",
        "1234abcd",
    ])
    func reject_nonDigitCharacters(phoneNumber: String) {
        #expect(PhoneNumber(phoneNumber: phoneNumber) == nil)
    }
}
