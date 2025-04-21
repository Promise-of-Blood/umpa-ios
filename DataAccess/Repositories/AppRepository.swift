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
            Major.piano,
            Major.composition,
            Major.drum,
            Major.bass,
            Major.guitar,
            Major.vocal,
            Major.electronicMusic,
            Major.windInstrument,

        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
#endif
