//
//  Int+Duration.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import Foundation

extension Int {
    func formattedDuration() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        var components: [String] = []
        if hours > 0 {
            components.append("\(hours)h")
        }
        if minutes > 0 {
            components.append("\(minutes)m")
        }
        return components.joined(separator: " ")
    }
}
