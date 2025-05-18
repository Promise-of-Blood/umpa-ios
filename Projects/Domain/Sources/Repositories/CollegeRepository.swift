// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol CollegeRepository {
    func fetchCollegeList() -> AnyPublisher<[College], Error>
}
