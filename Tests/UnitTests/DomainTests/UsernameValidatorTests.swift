// Created for Umpa in 2025

@testable import Domain
import Testing

@Suite(.tags(.domain))
struct UsernameValidatorTests {
    @Test("유효한 길이 조건 테스트", arguments: [
        "12345678",
        "한글로여덟글자다",
        "abcdefgh",
    ])
    func validateLengthToSucceed(rawUsername: String) throws {
        let usernameValidator = StudentCreateData.UsernameValidator(rawUsername: rawUsername)
        try usernameValidator.validateLength()
    }

    @Test("유효하지 않은 길이 조건 테스트", arguments: [
        "12345678910",
        "안녕하세요제이름은길어요",
        "abcdefghijklm",
    ])
    func validateLengthToFail(rawUsername: String) throws {
        #expect(throws: StudentCreateData.UsernameError.invalidLength) {
            let usernameValidator = StudentCreateData.UsernameValidator(rawUsername: rawUsername)
            try usernameValidator.validateLength()
        }
    }

    @Test("유효한 문자 조건 테스트", arguments: [
        "안녕123",
        "HelloWorld",
        "뛝뛝뚫쒫꿡뚫쒫꿡",
    ])
    func validateCharacterToSucceed(rawUsername: String) throws {
        let usernameValidator = StudentCreateData.UsernameValidator(rawUsername: rawUsername)
        try usernameValidator.validateCharacter()
    }

    @Test("유효하지 않은 문자 조건 테스트", arguments: [
        "테스트!Test",
        "@1231434",
        "jae-won",
    ])
    func validateCharacterToFail(rawUsername: String) throws {
        #expect(throws: StudentCreateData.UsernameError.invalidCharacter) {
            let usernameValidator = StudentCreateData.UsernameValidator(rawUsername: rawUsername)
            try usernameValidator.validateCharacter()
        }
    }
}
