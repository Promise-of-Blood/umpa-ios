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
    case log
    case debug
    case error
}
