// Created for Umpa in 2025

public struct TimesByWeekday<T: Time>: Hashable {
    public let weekday: WeekDay
    public let startTime: T
    public let endTime: T

    public init(weekday: WeekDay, startTime: T, endTime: T) {
        self.weekday = weekday
        self.startTime = startTime
        self.endTime = endTime
    }
}
