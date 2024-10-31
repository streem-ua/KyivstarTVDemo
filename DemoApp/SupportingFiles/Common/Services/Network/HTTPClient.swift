//
//  HTTPClient.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 20.10.2024.
//

import Combine
import SwiftUI
import Foundation

protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}

protocol TokenProviderProtocol {
    func tokenPublisher() -> AnyPublisher<String, Error>
//    func refreshTokenPublisher() -> AnyPublisher<String, Error>
}

struct InvalidHTTPResponseError: Error { }

extension URLSession: HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), any Error> {
        return dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw InvalidHTTPResponseError()
                }
                return (result.data, httpResponse)
            })
            .catch { error -> AnyPublisher<(Data, HTTPURLResponse), Error> in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

class TokenProvider: TokenProviderProtocol {
    private var accessToken: String {
        get { APIConstants.accessToken }
        set { APIConstants.accessToken = newValue }
    }

    func tokenPublisher() -> AnyPublisher<String, Error> {
        return Just(accessToken)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class AuthenticatedHTTPClientDecorator: HTTPClient {

    let client: HTTPClient
    let tokenProvider: TokenProviderProtocol

    init(client: HTTPClient, tokenProvider: TokenProviderProtocol = TokenProvider()) {
        self.client = client
        self.tokenProvider = tokenProvider
    }

    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        return tokenProvider
            .tokenPublisher()
            .flatMap { accessToken -> AnyPublisher<(Data, HTTPURLResponse), Error> in
                var signedRequest = request
                signedRequest.allHTTPHeaderFields?.removeValue(forKey: "Authorization")
                signedRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                return self.client.publisher(request: signedRequest)
            }
            .eraseToAnyPublisher()
    }
}

struct GenericAPIHTTPRequestMapper {
    static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable {
        if (200..<300) ~= response.statusCode {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                let decodingError = error as! DecodingError
                let detailedError = decodeErrorDetails(error: decodingError, data: data)
                throw APIErrorHandler.decodingError(detailedError)
            }
        } else {
            if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                throw APIErrorHandler.customApiError(error)
            } else {
                let rawResponse = String(data: data, encoding: .utf8) ?? "No Data"
                throw APIErrorHandler.emptyErrorWithStatusCode("Status code: \(response.statusCode). Response: \(rawResponse)")
            }
        }
    }

    private static func decodeErrorDetails(error: DecodingError, data: Data) -> String {
        var errorMessage = "Decoding error: \(error.localizedDescription)\n"

        switch error {
        case .typeMismatch(let type, let context):
            errorMessage += "Type mismatch for type \(type): \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        case .valueNotFound(let type, let context):
            errorMessage += "Value not found for type \(type): \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        case .keyNotFound(let key, let context):
            errorMessage += "Key not found: \(key.stringValue): \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        case .dataCorrupted(let context):
            errorMessage += "Data corrupted: \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        @unknown default:
            errorMessage += "Unknown error: \(error)\n"
        }

        if let jsonString = String(data: data, encoding: .utf8) {
            errorMessage += "JSON Data: \(jsonString)\n"
        }

        return errorMessage
    }
}
