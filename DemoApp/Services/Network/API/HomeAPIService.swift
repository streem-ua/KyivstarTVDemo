//
//  HomeAPI.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation

protocol HomeAPIService {
    func getPromotions() async throws -> PromotionsResponse
    func getCategories() async throws -> CategoriesResponse
    func getContentGroups() async throws -> [ContentGroup]
}

final class HomeAPIServiceImpl: BaseAPI, HomeAPIService {
    func getPromotions() async throws -> PromotionsResponse {
        var request = GenericRequest(withMethod: .get, path: "templates/j_BRMrbcY-5W/data")
        request.authenticated = true

        return try await perform(request: request)
    }
    
    func getCategories() async throws -> CategoriesResponse {
        var request = GenericRequest(withMethod: .get, path: "templates/eO-fawoGqaNB/data")
        request.authenticated = true

        return try await perform(request: request)
    }
    
    func getContentGroups() async throws -> [ContentGroup] {
        var request = GenericRequest(withMethod: .get, path: "templates/PGgg02gplft-/data")
        request.authenticated = true

        return try await perform(request: request)
    }
    
}
