// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol ReviewRepository {
    func fetchReview() -> AnyPublisher<Review, Error>
    func fetchReviewList() -> AnyPublisher<[Review], Error>

    func postReview(_ review: ReviewCreateData) -> AnyPublisher<Void, Error>
}
