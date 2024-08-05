//
//  BusinessLogic.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import Foundation

protocol PromotionsUseCase {
    func execute() async throws -> [Promotion]
}

class PromotionsUseCaseImp: PromotionsUseCase {
    let promotionsClient: PromotionsClient
    
    init(_ promotionsClient: PromotionsClient) {
        self.promotionsClient = promotionsClient
    }
    
    func execute() async throws -> [Promotion] {
        let promotionsDTO = try await promotionsClient.getPromotions()
        return promotionsDTO.promotions.compactMap({ Promotion($0) })
    }
}

fileprivate extension Promotion {
     init(_ dto: PromotionResponseDTO.PromotionDTO) {
        self.id = dto.id
        self.name = dto.name
        self.image = dto.image
    }
}
