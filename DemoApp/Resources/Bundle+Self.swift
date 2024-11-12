//
//  Bundle+Self.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import Foundation

extension Bundle {
    static var `self`: Bundle { Bundle(for: `Self`.self) }
    class `Self` {}
}
