//
//  OptionalProtocol.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import Foundation

/// An optional protocol for use in type constraints.
protocol OptionalProtocol {
    /// The type contained in the otpional.
    associatedtype Wrapped

    init(reconstructing value: Wrapped?)

    /// Extracts an optional from the receiver.
    var optional: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    var optional: Wrapped? { self }

    init(reconstructing value: Wrapped?) {
        self = value
    }
}
