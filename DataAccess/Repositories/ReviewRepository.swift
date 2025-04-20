// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultReviewRepository {
    public init() {}
}

extension DefaultReviewRepository: ReviewRepository {
    public func fetchReview() -> AnyPublisher<Domain.Review, any Error> {
        fatalError()
    }

    public func fetchReviewList() -> AnyPublisher<[Domain.Review], any Error> {
        fatalError()
    }

    public func postReview(_ review: Domain.ReviewCreateData) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}

#if DEBUG
public struct StubReviewRepository {
    public init() {}
}

extension StubReviewRepository: ReviewRepository {
    public func fetchReview() -> AnyPublisher<Domain.Review, any Error> {
        Just(Review.sample0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func fetchReviewList() -> AnyPublisher<[Domain.Review], any Error> {
        Just([Review.sample0, .sample1])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func postReview(_ review: Domain.ReviewCreateData) -> AnyPublisher<Void, any Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
#endif
