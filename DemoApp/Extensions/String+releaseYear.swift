//
//  String+releaseYear.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import Foundation

extension String {
    func releaseYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        }
        return self
    }
}
