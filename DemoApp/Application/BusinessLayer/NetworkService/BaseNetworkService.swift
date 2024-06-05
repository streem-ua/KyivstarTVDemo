//
//  NetworkService.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import Foundation

class BaseNetworkService<Endpoint: TargetType> {
    
    func fetchData<T:Decodable>(api: Endpoint) async throws -> T {
        let request = try await createRequest(api: api)
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    break
                case 401:
                    throw NetworkError.unauthorized
                case 402:
                    throw NetworkError.paymentRequired
                default:
                    throw NetworkError.dataLoadingError(httpResponse.statusCode)
                }
            }
            
            let result: T = try await decode(data: data)
            return result
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown
        }
    }
    
    private func createRequest(api: Endpoint) async throws -> URLRequest {
        let url = try await createUrl(type: api)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = api.headers
        return request
    }
    
    private func createUrl(type: Endpoint) async throws -> URL {
        var components = URLComponents()
        components.scheme = type.scheme
        components.host = type.host
        components.path = type.path
        guard let url = components.url else {throw NetworkError.invalidURL}
        print(url)
        return url
    }
    
    private func decode<T:Decodable>(data: Data) async throws -> T {
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: data) else {throw NetworkError.jsonDecodeError}
        return result
    }
}
