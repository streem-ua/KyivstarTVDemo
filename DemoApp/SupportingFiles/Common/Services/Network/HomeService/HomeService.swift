//
//  HomeService.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 20.10.2024.
//

import Combine
import Foundation

class HomeService {

    let httpClient: AuthenticatedHTTPClientDecorator

    init(httpClient: AuthenticatedHTTPClientDecorator) {
        self.httpClient = httpClient
    }
    
    func getContentGroups() -> AnyPublisher<ContentGroupResponseModel, Error> {
        return httpClient
            .publisher(request: HomeServiceProvider.getContentGroups.makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .eraseToAnyPublisher()
    }

    func getPromotions() -> AnyPublisher<PromotionsResponseModel, Error> {
        return httpClient
            .publisher(request: HomeServiceProvider.getPromotions.makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .eraseToAnyPublisher()
    }

    func getCategories() -> AnyPublisher<CategoriesResponseModel, Error> {
        return httpClient
            .publisher(request: HomeServiceProvider.getCategories.makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .eraseToAnyPublisher()
    }

    func getAssetDetails() -> AnyPublisher<AssetDetailsResponseModel, Error> {
        return httpClient
            .publisher(request: HomeServiceProvider.getAssetDetails.makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .eraseToAnyPublisher()
    }
}

