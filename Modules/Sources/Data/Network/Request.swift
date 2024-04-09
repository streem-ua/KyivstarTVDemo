//
//  Request.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - Request
protocol Request {
    var endpoint: Endpoint { get }
    var parameters: [URLQueryItem]? { get }
    var repeatCount: Int { get }
    var attempt: Int { get }

    mutating func repeatAttempt()
}

struct RequestWithResponse<T: Decodable>: Request {
    let endpoint: Endpoint
    let parameters: [URLQueryItem]?
    let repeatCount: Int
    private(set) var attempt: Int

    init(endpoint: Endpoint, query: [URLQueryItem]? = nil, repeatCount: Int = 3) {
        self.endpoint = endpoint
        self.parameters = query
        self.repeatCount = 3
        self.attempt = 0
    }

    mutating func repeatAttempt() {
        attempt += 1
    }
}

struct RequestWithoutResponse: Request {
    let endpoint: Endpoint
    let parameters: [URLQueryItem]?
    let repeatCount: Int
    private(set) var attempt: Int

    init(endpoint: Endpoint, query: [URLQueryItem]? = nil, repeatCount: Int = 3) {
        self.endpoint = endpoint
        self.parameters = query
        self.repeatCount = 3
        self.attempt = 0
    }

    mutating func repeatAttempt() {
        attempt += 1
    }
}
