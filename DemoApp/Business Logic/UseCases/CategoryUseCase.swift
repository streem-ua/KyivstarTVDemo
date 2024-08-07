//
//  CategoryUseCase.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

protocol CategoryUseCase {
    func execute() async throws -> [Category]
}

class CategoryUseCaseImp: CategoryUseCase {
    let categoryClient: CategoryClient
    
    init(_ categoryClient: CategoryClient) {
        self.categoryClient = categoryClient
    }
    
    func execute() async throws -> [Category] {
        let promotionsDTO = try await categoryClient.getCategories()
        return promotionsDTO.categories.compactMap({ Category($0) })
    }
}

fileprivate extension Category {
     init(_ dto: CategoryResponseDTO.CategoryDTO) {
        self.id = dto.id
        self.name = dto.name
        self.image = dto.image
    }
}
