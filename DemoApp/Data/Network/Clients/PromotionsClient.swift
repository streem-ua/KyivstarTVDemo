//
//  PromotionsClient.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import Foundation

protocol PromotionsClient {
    func getPromotions() async throws -> PromotionResponseDTO
}

final class PromotionsClientImp: PromotionsClient {
    func getPromotions() async throws -> PromotionResponseDTO {
        let response: PromotionResponseDTO = try await ApiClient.get(APIEnpointURL.getPromotionsURL())
        return response
    }
}
