// Created for Umpa in 2025

import Combine
import Foundation

public protocol AccompanimentInstrumentRepository {
    func fetchAccompanimentInstrumentList() -> AnyPublisher<[AccompanimentInstrument], Error>
}
