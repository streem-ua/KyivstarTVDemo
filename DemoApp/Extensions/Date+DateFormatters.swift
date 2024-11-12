//
//  Date+DateFormatters.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

extension Date {
    static let releaseDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    func toYear() -> String {
        return Date.releaseDateFormatter.string(from: self)
    }
}
