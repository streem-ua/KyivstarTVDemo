//
//  PromotionsAPI.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - PromotionsAPI
struct PromotionsAPI: Codable {
    let id, name: String
    let promotions: [PromotionAPI]
}

// MARK: - Promotion
struct PromotionAPI: Codable {
    let id, name: String
    let image: String
    let company, updatedAt, releaseDate: String
}
