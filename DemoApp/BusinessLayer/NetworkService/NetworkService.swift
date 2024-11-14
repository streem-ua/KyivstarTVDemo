//
//  NetworkService.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import Foundation

final class NetworkService: BaseNetworkService<Endpoint> {
    
    func contentGroups() async throws -> ContentGroups {
        try await fetchData(api: .contentGroups)
    }
    
    func promotions() async throws -> Promotions {
        try await fetchData(api: .promotions)
    }
    
    func categories() async throws -> Categories {
        try await fetchData(api: .categories)
    }
    
    func assetDetails() async throws -> AssetDetails {
        try await fetchData(api: .assetDetails)
    }
}
