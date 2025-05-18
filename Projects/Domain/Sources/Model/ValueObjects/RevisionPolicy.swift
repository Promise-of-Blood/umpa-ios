// Created for Umpa in 2025

import Foundation

/// 수정 정책
public struct RevisionPolicy: Hashable {
    public let freeCount: Int
    public let price: Int

    public init(freeCount: Int, price: Int) {
        self.freeCount = freeCount
        self.price = price
    }
}
