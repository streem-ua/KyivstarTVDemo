//
//  ApiClient.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

class ApiClient {
    private static let token = "Bearer vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"
    
    static func get<T:Decodable>(_ url: URL) async throws -> T {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        let (data, _) = try await session.data(for: request)
        let responseModel = try JSONDecoder().decode(T.self, from: data)
        return responseModel
    }
}
