//
//  DecodingError+Debug.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

extension DecodingError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .dataCorrupted(let context): "Data corrupted @ \(context.keyPath)"
        case .keyNotFound(let key, let context): "Key '\(key.keyPath)' not found @ \(context.keyPath)"
        case .typeMismatch(let type, let context): "Type mismatch '\(type)' @ \(context.keyPath)"
        case .valueNotFound(let type, let context): "Value '\(type)' not found @ \(context.keyPath)"
        @unknown default: "Unknown error"
        }
    }
}

private extension DecodingError.Context {
    var keyPath: String {
        codingPath.map { $0.keyPath }.joined(separator: ".")
    }
}

private extension CodingKey {
    var keyPath: String {
        intValue.flatMap(String.init) ?? stringValue
    }
}
