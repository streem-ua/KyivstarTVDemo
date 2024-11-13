//
//  Promotions.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation

struct PromotionsResponse: Decodable {
    struct Promotion: Decodable, Hashable {
        let id: String
        let name: String
        let image: String
        let company: String
        let updatedAt: String
        let releaseDate: String
    }
    
    let id: String
    let name: String
    let promotions: [Promotion]
}
