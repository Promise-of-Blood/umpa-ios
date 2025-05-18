// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol MajorRepository {
    func fetchMajorList() -> AnyPublisher<[Major], Error>
}
