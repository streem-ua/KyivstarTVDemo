//
//  String+.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
