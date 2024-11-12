//
//  HomeEndpoint.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

enum HomeEndpoint {
    case contentGroup(completion: IsSuccessWithDataCompletion<[ContentGroup]?>)
    case promotions(completion: IsSuccessWithDataCompletion<[Promotion]?>)
    case category(completion: IsSuccessWithDataCompletion<[Category]?>)
}

extension HomeEndpoint: PEndpointData {
    var urlPath: PURLPath {
        switch self {
        case .contentGroup: URLPath.Home.contentGroup
        case .promotions:   URLPath.Home.promotions
        case .category:     URLPath.Home.category
        }
    }
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
        case .contentGroup(let completion):
            let model = data?.decode([ContentGroup].self)
            completion(isSuccess, model)
        case .promotions(let completion):
            let model = data?.decode(PromotionModel.self)
            completion(isSuccess, model?.promotions)
        case .category(let completion):
            let model = data?.decode(CategoryModel.self)
            completion(isSuccess, model?.categories)
        }
    }
}
