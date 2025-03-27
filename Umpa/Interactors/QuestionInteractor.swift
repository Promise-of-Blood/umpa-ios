// Created for Umpa in 2025

import Factory
import Foundation
import Networking
import SwiftUI

protocol QuestionInteractor {
    @MainActor
    func load(_ questions: Binding<[Question]>) async throws

    @MainActor
    func loadQuestions() async throws -> [Question]

    @MainActor
    func loadQuestion(by id: Question.Id) async throws -> Question
}

struct DefaultQuestionInteractor: QuestionInteractor {
    func load(_ questions: Binding<[Question]>) async throws {
        fatalError()
    }

    func loadQuestions() async throws -> [Question] {
        fatalError()
    }

    func loadQuestion(by id: Question.Id) async throws -> Question {
        fatalError()
    }
}

enum QuestionInteractorError: Error {
    case invalidId
}

#if DEBUG
struct MockQuestionInteractor: QuestionInteractor {
    func load(_ questions: Binding<[Question]>) async throws {
        questions.wrappedValue = try await loadQuestions()
    }

    func loadQuestions() async throws -> [Question] {
        try await _loadQuestions()
    }

    func loadQuestion(by id: Question.Id) async throws -> Question {
        let questions = try await _loadQuestions()
        let foundQuestion = questions.first { $0.id == id }
        guard let foundQuestion else {
            throw QuestionInteractorError.invalidId
        }
        return foundQuestion
    }

    private func _loadQuestions() async throws -> [Question] {
        [
            Question.sample0,
            Question.sample1,
            Question.sample2,
        ]
    }
}
#endif
