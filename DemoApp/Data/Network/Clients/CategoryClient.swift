//
//  CategoryClient.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

protocol CategoryClient {
    func getCategories() async throws -> CategoryResponseDTO
}

class CategoryClientImp: CategoryClient {
    func getCategories() async throws -> CategoryResponseDTO {
        let response: CategoryResponseDTO = try await ApiClient.get(APIEnpointURL.getCategoriesURL())
        return response
    }
}
