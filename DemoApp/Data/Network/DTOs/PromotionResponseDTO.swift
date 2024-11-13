//
//  PromotionResponseModel.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import Foundation

struct PromotionResponseDTO: Decodable {
    let id: String
    let name: String
    let promotions: [PromotionDTO]
}

extension PromotionResponseDTO {
    struct PromotionDTO: Decodable {
        let id: String
        let name: String
        let image: String
        let company: String
        let updatedAt: String
        let releaseDate: String
    }
}
