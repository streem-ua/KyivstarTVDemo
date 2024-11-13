//
//  APIError.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Alamofire

// MARK: - APIError
public struct APIError: Decodable, LocalizedError {
    static let codeRange = 400..<600
    
    let error: String?
    let errors: [String]?
    public let httpCode: Int
    
    public var status: Status {
        APIError.codeRange ~= httpCode ? .serverError : .other
    }
}

// MARK: - Initialize
extension APIError {
    public init(_ response: Response, httpCode: Int) {
        error = response.error
        errors = response.errors
        self.httpCode = httpCode
    }
}

// MARK: - Response
extension APIError {
    public struct Response: Decodable {
        let error: String?
        let errors: [String]?
    }
}

// MARK: - Properties
extension Error {
    public var apiError: APIError? {
        if let apiError = self as? APIError {
            return apiError
        } else if let networkError = self as? NetworkError, case .api(let apiError) = networkError {
            return apiError
        } else if let networkError = self as? NetworkError, case .underlying(let someError) = networkError {
            return someError.apiError
        } else {
            return nil
        }
    }
    
    public var sessionTaskFailed: NetworkError? {
        if let error = self as? NetworkError, case .sessionTaskFailed = error {
            return error
        } else if let error = self as? NetworkError,
                  case .underlying(let underlyError) = error,
                  let networkError = underlyError as? NetworkError {
            return networkError.sessionTaskFailed
        } else if let error = self as? NetworkError,
                  case .underlying(let underlyError) = error,
                  let afError = underlyError as? AFError {
            return afError.sessionTaskFailed
        } else if let error = self as? AFError, case .sessionTaskFailed = error {
            return .sessionTaskFailed(error)
        }
        return nil
    }
}
