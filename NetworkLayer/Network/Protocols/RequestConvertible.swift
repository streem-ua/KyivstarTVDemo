//
//  RequestConvertible.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

public protocol RequestConvertible {
    /// Base URL for request, takes precedence over `baseURL` in `Network` if specified.
    var baseURL: URL? { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: Network.Method { get }

    /// The type of HTTP task to be performed.
    var task: Network.Task { get }

    /// The headers to be used in the request.
    var headers: Network.Headers? { get }
    
    /// The last part of the `baseURL` path
    var suffix: String { get }

    /// Specify authorization strategy for request.
    var authorizationStrategy: AuthorizationStrategy? { get }
}

extension RequestConvertible {
    public var baseURL: URL? { nil }

    public var headers: Network.Headers? { nil }

    public var authorizationStrategy: AuthorizationStrategy? { .token }
    
    public var suffix: String { "" }
}
