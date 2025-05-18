// Created for Umpa in 2025

import Foundation

public protocol Time: Hashable {}

/// [시, 분] 시각
public struct HMTime: Time, Hashable {
    public let hour: Int
    public let minute: Int

    public init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
}
