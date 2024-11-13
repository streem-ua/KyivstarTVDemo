//
//  GenericRequest.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    /* - Can be added others cases - **/
}

struct GenericRequest {
    var baseURL = ServiceConstants.baseUrl
    var method: HTTPMethod
    var path: String
    var authenticated: Bool = false
    var queryParameters: [String: String]?
    var httpBody: [[String: Any]]?

    var url: String {

        if let queryParameters = queryParameters {
            if var components = URLComponents(string: "\(urlWithPath)") {
                components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
                return components.string ?? ""
            }

            let pairs: [String] = queryParameters.map { $0.key + "=" + $0.value }
            return "\(urlWithPath)?" + pairs.joined(separator: "&")
        }

        return urlWithPath
    }

    private var urlWithPath: String {
        return baseURL + "/" + path
    }

    init(withMethod method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
}
