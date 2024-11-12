//
//  Int+FormatToHoursAndMinutes.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

extension Int {
    func formatToHoursAndMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60

        var formattedString = ""

        if hours > 0 {
            formattedString += "\(hours)h"
        }

        if minutes > 0 {
            if !formattedString.isEmpty {
                formattedString += " "
            }
            formattedString += "\(minutes)m"
        }

        if formattedString.isEmpty {
            formattedString = "0m"
        }

        return formattedString
    }
}
