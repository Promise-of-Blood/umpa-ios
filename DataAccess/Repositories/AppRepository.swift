// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultAppRepository {
    private let network: Network

    public init(network: Network) {
        self.network = network
    }
}

extension DefaultAppRepository: AppRepository {
    public func fetchMajorList() -> AnyPublisher<[Domain.Major], any Error> {
        let request = GetMajorsRequest()
        return network.requestPublisher(request)
            .map { $0.compactMap { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}

#if DEBUG
public struct StubAppRepository: AppRepository {
    public init() {}

    public func fetchMajorList() -> AnyPublisher<[Domain.Major], any Error> {
        Just([
            Major(name: "피아노"),
            Major(name: "작곡"),
            Major(name: "드럼"),
            Major(name: "베이스"),
            Major(name: "기타"),
            Major(name: "보컬"),
            Major(name: "전자음악"),
            Major(name: "관악"),
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
#endif
