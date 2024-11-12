//
//  Promotion.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

struct PromotionModel: Codable, Hashable {
    let id: String?
    let name: String?
    let promotions: [Promotion]?
}

struct Promotion: Codable, Hashable {
    let id: String?
    let name: String?
    let image: String?
    let company: String?
    let updatedAt: String?
    let releaseDate: String?
}
