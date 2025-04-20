// Created for Umpa in 2025

import Combine
import Mockable

@Mockable
public protocol AppRepository {
    func fetchMajorList() -> AnyPublisher<[Major], Error>
}
