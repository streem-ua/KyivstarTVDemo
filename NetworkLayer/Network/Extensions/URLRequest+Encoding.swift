//
//  URLRequest+Encoding.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Alamofire

extension URLRequest {
    private func encoded(_ parameters: Alamofire.Parameters, encoding: Alamofire.ParameterEncoding) throws -> URLRequest {
        do {
            return try encoding.encode(self, with: parameters)
        } catch {
            throw NetworkError.parametersEncoding(error)
        }
    }

    func encoded(for target: RequestConvertible) throws -> URLRequest {
        switch target.task {
        case .requestData(let body):
            with(self) { $0.httpBody = body }
        case .requestCompositeData(let body, let urlParameters):
            try with(self) { $0.httpBody = body }
                .encoded(urlParameters, encoding: URLEncoding.default)
        case .requestCompositeParameters(let bodyParameters,
                                         let bodyEncoding,
                                         let urlParameters):
            try encoded(bodyParameters, encoding: bodyEncoding)
                .encoded(urlParameters, encoding: URLEncoding.default)
        default:
            self
        }
    }
}
