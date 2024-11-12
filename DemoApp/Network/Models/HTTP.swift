//
//  HTTP.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

struct HTTP {
    private init() {}
    enum Method: String {
        case get    = "GET"
    }
    enum ContentType: Equatable {
        case json
    }
    typealias Body   = [String: Any]
    typealias Header = [String: String]
}
