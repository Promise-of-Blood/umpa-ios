// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultCollegeRepository {
    private let network: Network

    public init(network: Network) {
        self.network = network
    }
}

extension DefaultCollegeRepository: CollegeRepository {
    public func fetchCollegeList() -> AnyPublisher<[College], any Error> {
        fatalError()
    }
}
