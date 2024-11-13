//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Alamofire

// MARK: - NetworkError
public enum NetworkError: Error {
    case missingResponse
    case sessionRequired
    case parametersEncoding(Error)
    case underlying(Error)
    case decoding(DecodingError, URL?)
    case api(APIError)
    case noInternetConnection
    case sessionTaskFailed(Error)
    case unknown
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingResponse: "Missing response from server"
        case .sessionRequired: "Session is required"
        case .parametersEncoding: "Failed to encode request parameters"
        case .underlying(let error): error.localizedDescription
        case .api(let error): error.localizedDescription
        case let .decoding(error, url): handleDecodingError(error, url: url)
        case .noInternetConnection: "No internet connection"
        case .sessionTaskFailed(let error): error.localizedDescription
        case .unknown: "Unknown error"
        }
    }
    
    private func handleDecodingError(_ error: DecodingError, url: URL?) -> String {
        var errorMessage = ""
        switch error {
        case .dataCorrupted(let context):
            errorMessage = "\(error.debugDescription)\n\(context.debugDescription)\n\(context.codingPath)"
        case let .keyNotFound(key, context):
            errorMessage = "\(error.debugDescription)\n\(key.description)\n\(context.debugDescription)\n\(context.codingPath)"
        case let .typeMismatch(type, context):
            errorMessage = "\(error.debugDescription)\n\(type)\n\(context.debugDescription)\n\(context.codingPath)"
        case let .valueNotFound(type, context):
            errorMessage = "\(error.debugDescription)\n\(type)\n\(context.debugDescription)\n\(context.codingPath)"
        @unknown default:
            errorMessage = "\(error.debugDescription)"
        }
        url.flatMap { errorMessage += "\nurl: \($0.absoluteString)" }
        return errorMessage
    }
}

// MARK: - Initialize
extension NetworkError {
    public init(_ error: Error?) {
        switch error {
        case let apiError as APIError:
            self = .api(apiError)
        case let decodingError as DecodingError:
            self = .decoding(decodingError, nil)
        case .none:
            self = .unknown
        case .some(let error):
            if let afError = error as? AFError, case .sessionTaskFailed = afError {
                self = .sessionTaskFailed(error)
            }
            self = .underlying(error)
        }
    }
}
