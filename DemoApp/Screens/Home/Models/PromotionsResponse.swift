//
//  PromotionsResponse.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

// MARK: - PromotionsResponse
struct PromotionsResponse: Codable {
    let id, name: String
    let promotions: [Promotion]
}

// MARK: - Promotion
struct Promotion: Codable, Hashable {
    let id, name: String
    let image: String
    let company, updatedAt, releaseDate: String
}
