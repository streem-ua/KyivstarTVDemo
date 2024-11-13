//
//  DateFormatter+Extension.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

extension DateFormatter {
    static var iso8601: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = .enUSPOSIX
        formatter.timeZone = .utc
        return formatter
    }

    static var release: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = .enUSPOSIX
        formatter.timeZone = .utc
        return formatter
    }
}
