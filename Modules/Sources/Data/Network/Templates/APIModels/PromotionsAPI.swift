//
//  PromotionsAPI.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - PromotionsAPI
public struct PromotionsAPI: Codable {
    public let id, name: String
    public let promotions: [PromotionAPI]
}

// MARK: - Promotion
public struct PromotionAPI: Codable {
    public let id, name: String
    public let image: String
    public let company, updatedAt, releaseDate: String
}
