//
//  TemplatesRepository.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - TemplatesRepository
public protocol TemplatesRepository: AnyObject {
    func fetchContentGroups() async throws -> [ContentGroups]
    func fetchPromotions() async throws -> [Promotion]
    func fetchCategories() async throws -> [Category]
    func fetchAssetDetails() async throws -> AssetDetails
}

// MARK: - TemplatesRepositoryImpl
public final class TemplatesRepositoryImpl: TemplatesRepository {
    
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Init
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    public func fetchContentGroups() async throws -> [ContentGroups] {
        let request = RequestWithResponse<[ContentGroupsAPI]>(endpoint: TemplatesEndpoint.getContentGroups)
        let result = try await networkService.load(request)
        return result.map { $0.mapToDoamin() }
    }
    
    public func fetchPromotions() async throws -> [Promotion] {
        let request = RequestWithResponse<PromotionsAPI>(endpoint: TemplatesEndpoint.getPromotions)
        let result = try await networkService.load(request)
        return result.promotions.map { $0.mapToDoamin() }
    }
    
    public func fetchCategories() async throws -> [Category] {
        let request = RequestWithResponse<CategoriesAPI>(endpoint: TemplatesEndpoint.getCategories)
        let result = try await networkService.load(request)
        return result.categories.map { $0.mapToDoamin() }
    }
    
    public func fetchAssetDetails() async throws -> AssetDetails {
        let request = RequestWithResponse<AssetDetailsAPI>(endpoint: TemplatesEndpoint.getAssetDetails)
        let result = try await networkService.load(request)
        return result.mapToDoamin()
    }
}

