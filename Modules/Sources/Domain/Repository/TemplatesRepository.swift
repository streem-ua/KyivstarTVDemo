//
//  TemplatesRepository.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

public protocol TemplatesRepository {
    func fetchContentGroups() async throws -> [ContentGroupsDomain]
    func fetchPromotions() async throws -> PromotionsDomain
    func fetchCategories() async throws -> CategoriesDomain
    func fetchAssetDetails() async throws -> AssetDomain
}

public final class TemplatesRepositoryImpl: TemplatesRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func fetchContentGroups() async throws -> [ContentGroupsDomain] {
        let request = RequestWithResponse<[ContentGroupsAPI]>(endpoint: TemplatesEndpoint.getContentGroups)
        let result = try await networkService.load(request)
        return result.map { $0.mapToDoamin() }
    }
    
    public func fetchPromotions() async throws -> PromotionsDomain {
        let request = RequestWithResponse<PromotionsAPI>(endpoint: TemplatesEndpoint.getPromotions)
        let result = try await networkService.load(request)
        return result.mapToDoamin()
    }
    
    public func fetchCategories() async throws -> CategoriesDomain {
        let request = RequestWithResponse<CategoriesAPI>(endpoint: TemplatesEndpoint.getCategories)
        let result = try await networkService.load(request)
        return result.mapToDoamin()
    }
    
    public func fetchAssetDetails() async throws -> AssetDomain {
        let request = RequestWithResponse<AssetAPI>(endpoint: TemplatesEndpoint.getContentGroups)
        let result = try await networkService.load(request)
        return result.mapToDoamin()
    }
}

