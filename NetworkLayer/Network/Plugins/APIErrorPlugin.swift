//
//  APIErrorPlugin.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

public class APIErrorPlugin: NetworkPlugin {
    public init() {}
    
    public func process(_ result: Network.ResponseResult,
                        target: RequestConvertible) -> Network.ResponseResult {
        guard case .success(let response) = result,
              APIError.codeRange ~= response.statusCode else {
            return result
        }
        
        do {
            let responseError = try response.decode(APIError.Response.self)
            let apiError = APIError(responseError, httpCode: response.statusCode)
            return .failure(apiError)
        } catch {
            return .failure(error)
        }
    }
}
