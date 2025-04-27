// Created for Umpa in 2025

import Foundation

public struct StudentCreateData {
    let socialLoginType: SocialLoginType
    let name: String
    let username: String
    let major: String
    let dreamCollege1: String
    let dreamCollege2: String
    let dreamCollege3: String

    public init?(
        socialLoginType: SocialLoginType,
        name: String,
        username: String,
        major: String,
        dreamCollege1: String,
        dreamCollege2: String,
        dreamCollege3: String
    ) {
        self.socialLoginType = socialLoginType
        self.name = name
        self.username = username
        self.major = major
        self.dreamCollege1 = dreamCollege1
        self.dreamCollege2 = dreamCollege2
        self.dreamCollege3 = dreamCollege3
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
