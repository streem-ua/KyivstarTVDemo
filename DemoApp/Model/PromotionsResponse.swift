//
//  PromotionsResponse.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import Foundation

struct PromotionsResponse: Codable {
    let promotions: [Promotion]
}

struct Promotion: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let image: String
    let company: String
    let updatedAt: String
    let releaseDate: String
}
