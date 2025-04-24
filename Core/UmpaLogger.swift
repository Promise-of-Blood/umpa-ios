// Created for Umpa in 2025

import Foundation
import OSLog

public enum UmpaLogger {
    private static let logger = Logger(subsystem: "Umpa", category: "default")

    public static func log(_ message: String, level: LogLevel = .log) {
        let prefix = "[Umpa] : "

        switch level {
        case .log:
            logger.log("\(prefix)\(message)")
        case .debug:
            logger.debug("\(prefix)\(message)")
        case .error:
            logger.error("\(prefix)\(message)")
        }
    }
}

public enum LogLevel {
    /// 앱의 정상적인 동작을 나타내는 정보
    case log

    /// 개발 또는 디버깅에 도움이 될 수 있는 정보
    @available(*, deprecated,
               renamed: "log",
               message: "현재 Console에 `debug`레벨의 로그는 출력되지 않는 이슈가 있어 해결될 때까지 `log`레벨 사용을 권장합니다.")
    case debug

    /// 앱의 동작에 문제가 발생했음을 나타내는 정보
    case error
}
