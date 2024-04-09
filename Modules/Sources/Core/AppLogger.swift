//
//  AppLogger.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import OSLog

public typealias AppLogger = Logger

extension Logger {

    enum LogCategory: String {
        case networkService
       
        func callAsFunction() -> String {
            self.rawValue
        }
    }

    private static var bundleIdentifier: String {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            fatalError("No bundle identifier was found")
        }
        return bundleIdentifier
    }

    public static let networkService = Logger.with(category: .networkService)
}

extension Logger {

    static func with(category: LogCategory) -> Logger {
        return Logger(subsystem: bundleIdentifier, category: category())
    }
}

