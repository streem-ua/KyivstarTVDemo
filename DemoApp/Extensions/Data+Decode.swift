//
//  Data+Decode.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder {}

extension Data {
    func decode<T: Decodable>(_ type: T.Type, statusCode: HTTP.StatusCode? = nil) -> T? {
        do {
            return try JsonDataDecoderWithToast.decode(type.self, data: self, statusCode: statusCode)
        } catch {
            let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
            debugPrint(error.localizedDescription, error, json ?? [:],
                     separator: "\n\n----------------------\n\n")
            return nil
        }
    }
}

extension Data {
    func decoded<T: Decodable>(with decoder: AnyDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
    func decode<T: Decodable>(type: T.Type, decoder: AnyDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(type.self, from: self)
    }
}
