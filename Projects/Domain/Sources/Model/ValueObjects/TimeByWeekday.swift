// Created for Umpa in 2025

public struct TimeByWeekday<T: Time>: Hashable {
    public let weekday: Weekday
    public let startTime: T
    public let endTime: T

    public init(weekday: Weekday, startTime: T, endTime: T) {
        self.weekday = weekday
        self.startTime = startTime
        self.endTime = endTime
    }
}
