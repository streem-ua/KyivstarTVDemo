//
//  CachedRequestConvertible.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

struct CachedRequestConvertible: RequestConvertible {
    let baseURL: URL?
    let path: String
    let method: Network.Method
    let task: Network.Task
    let headers: Network.Headers?
    let suffix: String
    let authorizationStrategy: AuthorizationStrategy?

    init(_ target: RequestConvertible) {
        baseURL = target.baseURL
        path = target.path
        method = target.method
        task = target.task
        headers = target.headers
        suffix = target.suffix
        authorizationStrategy = target.authorizationStrategy
    }
}
