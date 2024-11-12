//
//  DetailsEndpoint.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

enum DetailsEndpoint {
    case assetDetails(completion: IsSuccessWithDataCompletion<AssetDetails?>)
}

extension DetailsEndpoint: PEndpointData {
    var urlPath: PURLPath { URLPath.Details.assetDetails }
    var method: HTTP.Method { .get }
    var body: HTTP.Body? { nil }
    // MARK: - Interface
    func handleResponseResult(_ responseResult: ResponseResult) {
        switch responseResult {
        case .success(let data, let statusCode):
            handleCompletions(statusCode: statusCode, data: data)
        case .error:
            handleCompletions(statusCode: nil, data: nil)
        }
    }
    // MARK: - Private methods
    private func handleCompletions(statusCode: HTTP.StatusCode?, data: Data?) {
        let isSuccess = statusCode?.isSuccess ?? false
        switch self {
        case .assetDetails(let completion):
            let model = data?.decode(AssetDetails.self)
            completion(isSuccess, model)
        }
    }
}
