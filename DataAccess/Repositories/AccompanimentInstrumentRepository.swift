// Created for Umpa in 2025

import Combine
import Domain
import Foundation

public struct DefaultAccompanimentInstrumentRepository {
    let network: Network

    public init(network: Network) {
        self.network = network
    }
}

extension DefaultAccompanimentInstrumentRepository: AccompanimentInstrumentRepository {
    public func fetchAccompanimentInstrumentList() -> AnyPublisher<[AccompanimentInstrument], Error> {
        fatalError()
    }
}

#if DEBUG
public struct StubAccompanimentInstrumentRepository: AccompanimentInstrumentRepository {
    public init() {}

    public func fetchAccompanimentInstrumentList() -> AnyPublisher<[AccompanimentInstrument], Error> {
        Just([
            AccompanimentInstrument(name: "피아노"),
            AccompanimentInstrument(name: "보컬"),
            AccompanimentInstrument(name: "작곡"),
            AccompanimentInstrument(name: "드럼"),
            AccompanimentInstrument(name: "기타"),
            AccompanimentInstrument(name: "베이스"),
            AccompanimentInstrument(name: "관악"),
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
#endif
