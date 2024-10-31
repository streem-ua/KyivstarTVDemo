//
//  String + ext.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import Foundation

extension String {
    func toYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        }
        return nil
    }
}
