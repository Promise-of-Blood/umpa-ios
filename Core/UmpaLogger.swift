// Created for Umpa in 2025

import Foundation
import OSLog

public struct UmpaLogger {
    public enum Category: String {
        case `default`
        case signUp
        case component
    }

    public enum LogLevel {
        /// 앱의 정상적인 동작을 나타내는 정보
        case log

        /// 개발 또는 디버깅에 도움이 될 수 있는 정보
        case debug

        /// 앱의 동작에 문제가 발생했음을 나타내는 정보
        case error
    }

    private static var logger = Logger(subsystem: "Umpa", category: Category.default.rawValue)

    private static let logPrefix = "[Umpa] : "

    public init(category: Category) {
        UmpaLogger.logger = Logger(subsystem: "Umpa", category: category.rawValue)
    }

    public static func log(_ message: String, level: LogLevel = .log) {
        switch level {
        case .log:
            logger.log("\(logPrefix)\(message)")
        case .debug:
//            logger.debug("\(prefix)\(message)")

            // 현재 Console에 `debug`레벨의 로그는 출력되지 않는 이슈가 있어 해결될 때까지 `log`레벨로 대체합니다.
            logger.log("\(logPrefix)\(message)")
        case .error:
            logger.error("\(logPrefix)\(message)")
        }
    }

    public func log(_ message: String, level: LogLevel = .log) {
        UmpaLogger.log(message, level: level)
    }
}
