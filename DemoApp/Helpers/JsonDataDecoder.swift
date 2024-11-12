//
//  JsonDataDecoder.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

struct JsonDataDecoderWithToast {
    static func decode<T: Decodable>(_ type: T.Type, data: Data, statusCode: HTTP.StatusCode?) throws -> T? {
        do {
            return try data.decode(type: T.self)
        } catch {
            guard statusCode?.isSuccess ?? true else { throw error }
            debugPrint(error.localizedDescription)
            throw error
        }
    }
}
