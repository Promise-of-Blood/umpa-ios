// Created for Umpa in 2025

import Combine
import Foundation

public protocol RegionRepository {
    func fetchRegionList() -> AnyPublisher<[String: [String]], Error>
}
