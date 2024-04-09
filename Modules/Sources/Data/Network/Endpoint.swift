//
//  Endpoint.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: ApiMethod { get }
}

enum ApiMethod: String {
    case post = "POST"
    case get = "GET"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
}
