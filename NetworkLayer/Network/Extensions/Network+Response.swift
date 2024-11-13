//
//  Network+Response.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Alamofire

// MARK: - Response
extension Network {
    public class Response {
        // MARK: - Properties
        public let response: HTTPURLResponse
        public let request: URLRequest?
        let data: Data
        let metrics: URLSessionTaskMetrics?

        var statusCode: Int {
            response.statusCode
        }

        // MARK: - Initialize
        public init(
            data: Data,
            response: HTTPURLResponse,
            request: URLRequest? = nil,
            metrics: URLSessionTaskMetrics? = nil
        ) {
            self.data = data
            self.request = request
            self.response = response
            self.metrics = metrics
        }
    }
}

// MARK: - Decode
extension Network.Response {
    public func decode<T: Decodable>(_ type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(type, from: data)
    }
}

// MARK: - Initialize
extension Network.Response {
    convenience init(_ dataResponse: DataResponse<Data, Error>) throws {
        try self.init(
            dataResponse.result,
            dataResponse.response,
            dataResponse.request,
            dataResponse.metrics
        )
    }

    convenience init(
        _ result: Result<Data, Error>,
        _ response: HTTPURLResponse?,
        _ request: URLRequest?,
        _ metrics: URLSessionTaskMetrics?
    ) throws {
        switch result {
        case .success(let data):
            guard let response else {
                throw NetworkError.missingResponse
            }
            self.init(
                data: data,
                response: response,
                request: request,
                metrics: metrics
            )
        case .failure(let error):
            throw error
        }
    }
}
