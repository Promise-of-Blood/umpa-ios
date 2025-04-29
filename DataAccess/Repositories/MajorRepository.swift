// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultMajorRepository {
    public init() {}
}

extension DefaultMajorRepository: MajorRepository {
    public func fetchMajorList() -> AnyPublisher<[Major], any Error> {
        fatalError()
    }
}
