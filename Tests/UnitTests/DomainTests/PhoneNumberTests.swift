// Created for Umpa in 2025

@testable import Domain
import Testing

@Suite(.tags(.domain))
struct PhoneNumberPresentedNumberTests {
    @Test func mobile_010_11Digits() throws {
        let phoneNumber = try PhoneNumber(phoneNumber: "01012345678")
        #expect(phoneNumber.presentedNumber == "010-1234-5678")
    }

    @Test func seoul_02_9Digits() throws {
        let phoneNumber = try PhoneNumber(phoneNumber: "021234567")
        #expect(phoneNumber.presentedNumber == "02-123-4567")
    }

    @Test func gyeonggi_031_10Digits() throws {
        let phoneNumber = try PhoneNumber(phoneNumber: "0311234567")
        #expect(phoneNumber.presentedNumber == "031-123-4567")
    }

    @Test func internetPhone_070_11Digits() throws {
        let phoneNumber = try PhoneNumber(phoneNumber: "07012345678")
        #expect(phoneNumber.presentedNumber == "070-1234-5678")
    }

    @Test func seoul_02_10Digits() throws {
        let phoneNumber = try PhoneNumber(phoneNumber: "0212345678")
        #expect(phoneNumber.presentedNumber == "02-1234-5678")
    }

    @Test("하이픈이 포함된 문자열 등 숫자가 아닌 문자가 들어올 때 예외 발생 확인", arguments: [
        "010-1234-5678",
        "abcd",
        "1234abcd",
    ])
    func reject_nonDigitCharacters(phoneNumber: String) {
        #expect(throws: DomainError.disallowedValue) {
            _ = try PhoneNumber(phoneNumber: phoneNumber)
        }
    }
}
