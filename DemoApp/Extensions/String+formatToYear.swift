//
//  String+formatToYear.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

extension String {
    func formatToYear() -> String? {
        let dateFormatter = Date.releaseDateFormatter

        guard let date = dateFormatter.date(from: self) else { return nil }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }
}
