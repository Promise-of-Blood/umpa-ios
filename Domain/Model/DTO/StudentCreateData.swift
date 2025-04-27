// Created for Umpa in 2025

import Foundation

public struct StudentCreateData {
    let socialLoginType: SocialLoginType
    let name: String
    let username: String
    let major: Major
    let dreamCollege0: String
    let dreamCollege1: String
    let dreamCollege2: String

    public init?(
        socialLoginType: SocialLoginType,
        name: String,
        username: String,
        major: Major?,
        dreamCollege0: String,
        dreamCollege1: String,
        dreamCollege2: String
    ) {
        guard let major else {
            return nil
        }

        self.socialLoginType = socialLoginType
        self.name = name
        self.username = username
        self.major = major
        self.dreamCollege0 = dreamCollege0
        self.dreamCollege1 = dreamCollege1
        self.dreamCollege2 = dreamCollege2
    }
}

// MARK: - UsernameValidator

extension StudentCreateData {
    public struct UsernameValidator: Validator {
        let rawUsername: String

        public init(rawUsername: String) {
            self.rawUsername = rawUsername
        }

        public func validate() -> Bool {
            do {
                try validateWithError()
                return true
            } catch {
                return false
            }
        }

        public func validateWithError() throws {
            do {
                try validateLength()
                try validateCharacter()
            } catch {
                throw error
            }
        }

        func validateLength() throws {
            let minLength = 1
            let maxLength = 8
            guard rawUsername.count >= minLength && rawUsername.count <= maxLength else {
                throw UsernameError.invalidLength
            }
        }

        func validateCharacter() throws {
            let disallowed = CharacterSet.alphanumerics
                .union(CharacterSet(charactersIn: "\u{AC00}" ... "\u{D7A3}"))
                .inverted
            guard rawUsername.rangeOfCharacter(from: disallowed) == nil else {
                throw UsernameError.invalidCharacter
            }
        }
    }

    public enum UsernameError: Error {
        case invalidLength
        case invalidCharacter
    }
}
