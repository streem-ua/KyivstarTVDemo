//
//  AssetsService.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import NetworkLayer
import Combine

final class AssetsService: AssetsUseCases {
    // MARK: - Private Properties
    private let network: Network
    
    // MARK: - Initialize
    init(network: Network) {
        self.network = network
    }
    
    // MARK: - Use Cases
    func getPromotionGroup() -> AsyncTask<PromotionGroup> {
        network.request(API.Assets.getPromotions)
            .decode(PromotionGroup.Response.self)
            .mapToAppError()
            .map(PromotionGroup.init)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getCategories() -> AsyncTask<CategoryGroup> {
        network.request(API.Assets.getCategories)
            .decode(CategoryGroup.Response.self)
            .mapToAppError()
            .map(CategoryGroup.init)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getContentGroups() -> AsyncTask<[AssetGroup]> {
        network.request(API.Assets.getContentGroups)
            .decode([AssetGroup.Response].self)
            .mapToAppError()
            .map { $0.map(AssetGroup.init) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getAssetDetails() -> AsyncTask<AssetDetail> {
        network.request(API.Assets.getAssetDetails)
            .decode(AssetDetail.Response.self)
            .mapToAppError()
            .map(AssetDetail.init)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
