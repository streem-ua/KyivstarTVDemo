//
//  URLRequest+BuildRequest.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

extension URLRequest {
    static func buildRequest(endpointData: PEndpointData) -> URLRequest {
        let url = getUrl(endpointData)
        let requestData = URLRequest(url: url, timeoutInterval: endpointData.requestTimeout ?? 15)
            .setRequestMethod(endpointData)
            .setHeader(endpointData)
        return requestData
    }
    // MARK: - Private methods
    private static func getUrl(_ endpointData: PEndpointData) -> URL {
        // URL
        var url = endpointData.urlPath.baseUrl ?? TaskManager.baseUrl
        let link = endpointData.urlPath.link
        url.appendPathComponent(link)
        return url
    }
    private func setRequestMethod(_ endpointData: PEndpointData) -> URLRequest {
        var request = self
        request.httpMethod = endpointData.method.rawValue
        return request
    }
    private func setHeader(_ endpointData: PEndpointData) -> URLRequest {
        var request = self
        switch endpointData.contentType {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        let authToken = NetworkSecurityParameters.authToken
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        endpointData.header?.forEach({ (header) in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        })
        return request
    }
}
