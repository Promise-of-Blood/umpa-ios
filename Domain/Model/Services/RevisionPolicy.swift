// Created for Umpa in 2025

import Foundation

public struct RevisionPolicy: Hashable {
    public let freeCount: Int
    public let price: Int

    public init(freeCount: Int, price: Int) {
        self.freeCount = freeCount
        self.price = price
    }
}
