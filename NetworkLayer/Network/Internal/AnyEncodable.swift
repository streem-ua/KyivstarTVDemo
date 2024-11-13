//
//  AnyEncodable.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

struct AnyEncodable: Encodable {
    let encodable: Encodable

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
