// Created for Umpa in 2025

import Foundation

public struct StudentCreateData {
    let socialLoginType: SocialLoginType
    let name: String
    let username: String
    let major: Major
    let dreamCollege0: College
    let dreamCollege1: College
    let dreamCollege2: College
    let profileImageData: Data?
    let grade: Grade?
    let gender: Gender?
    let preferSubject: LessonSubject?
    let lessonStyle: LessonStyle?
    let availableLessonDays: [Domain.Weekday]
    let lessonRequirements: String

    public init?(
        socialLoginType: SocialLoginType,
        name: String,
        username: String,
        major: Major?,
        dreamCollege0: College?,
        dreamCollege1: College?,
        dreamCollege2: College?,
        profileImageData: Data?,
        grade: Grade?,
        gender: Gender?,
        preferSubject: LessonSubject?,
        lessonStyle: LessonStyle?,
        availableLessonDays: [Domain.Weekday],
        lessonRequirements: String,
    ) {
        // FIXME: 조건 완성하기
        guard let major,
              UsernameValidator(rawUsername: username).validate(),
              let dreamCollege0,
              let dreamCollege1,
              let dreamCollege2
        else {
            return nil
        }

        self.socialLoginType = socialLoginType
        self.name = name
        self.username = username
        self.major = major
        self.dreamCollege0 = dreamCollege0
        self.dreamCollege1 = dreamCollege1
        self.dreamCollege2 = dreamCollege2
        self.profileImageData = profileImageData
        self.grade = grade
        self.gender = gender
        self.preferSubject = preferSubject
        self.lessonStyle = lessonStyle
        self.availableLessonDays = availableLessonDays
        self.lessonRequirements = lessonRequirements
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
