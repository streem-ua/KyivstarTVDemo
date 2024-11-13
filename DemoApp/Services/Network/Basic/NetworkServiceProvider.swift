//
//  NetworkServiceProvider.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation

enum NetworkServiceProviderError: Error {
    case badUrl
    case badResponse
    case badData
    case badInputDataSerialization
}

protocol NetworkServiceProvider {
    func perform<T:Decodable>(_ request: GenericRequest) async throws -> T
}

final class NetworkServiceProviderImpl: NetworkServiceProvider {
    private let token = "Bearer vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"

    private let session: URLSession
    private let decoder: JSONDecoder
    
    static let shared = NetworkServiceProviderImpl()
    
    private init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
        decoder = JSONDecoder()
    }
    
    // MARK: - Public
    
    func perform<T:Decodable>(_ request: GenericRequest) async throws -> T {

        guard let url = URL(string: request.url) else { throw NetworkServiceProviderError.badUrl }
        
        var resultRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        resultRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        resultRequest.setValue(token, forHTTPHeaderField: "Authorization")
        resultRequest.httpMethod = request.method.rawValue
                
        if let httpBody = request.httpBody {
            do {
                let data = try JSONSerialization.data(withJSONObject: httpBody, options: [])
                resultRequest.httpBody = data
            } catch {
                throw NetworkServiceProviderError.badInputDataSerialization
            }
        }
        
        return try await performRequest(resultRequest)
    }
    
    // MARK: - Private
    private func performRequest<T:Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)

            print(response)
            return try decodeObject(data)
        } catch {
            throw NetworkServiceProviderError.badResponse
        }
    }
    
    private func decodeObject<T:Decodable>(_ data: Data) throws -> T {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch {
            throw NetworkServiceProviderError.badData
        }

    }
}
