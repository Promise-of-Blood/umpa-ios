// Created for Umpa in 2025

import Combine

protocol Repository {
    func fetchReview() -> AnyPublisher<Review, Error>
    func fetchReviews() -> AnyPublisher<[Review], Error>
    
    func fetchPost() -> AnyPublisher<Post, Error>
    func fetchPosts() -> AnyPublisher<[Post], Error>
}
