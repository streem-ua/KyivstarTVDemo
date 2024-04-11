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
    var repeatCount: Int { get }
    var attempt: Int { get }

    mutating func repeatAttempt()
}

public struct RequestWithResponse<T: Decodable>: Request {
    public let endpoint: Endpoint
    public let repeatCount: Int
    private(set) var attempt: Int

    public init(endpoint: Endpoint, repeatCount: Int = 3) {
        self.endpoint = endpoint
        self.repeatCount = 3
        self.attempt = 0
    }

    mutating func repeatAttempt() {
        attempt += 1
    }
}
