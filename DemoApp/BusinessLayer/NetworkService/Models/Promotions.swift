//
//  Promotions.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 03.06.2024.
//

import Foundation


struct Promotions: Decodable {
    let id: String
    let name: String
    let promotions: [Promotion]
}

struct Promotion: Decodable, Hashable {
    let id: String
    let name: String
    let image: String
    let company: String
    let updatedAt: String
    let releaseDate: String
}

extension Promotions {
    func sectionModel() -> HomeSectionModel {
        let items = promotions.map { Home.Item.promotions($0) }
        return HomeSectionModel(section: .promotions, items: items)
    }
}
