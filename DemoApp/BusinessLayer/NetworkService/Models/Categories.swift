//
//  Categories.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 03.06.2024.
//

import Foundation

struct Categories: Decodable {
    let categories: [Category]
}

struct Category: Decodable, Hashable {
    let id: String
    let name: String
    let image: String
}

extension Categories {
    func categoriesItemType() -> HomeSectionModel {
        let items = categories.map { Home.Item.categories($0) }
        return HomeSectionModel(section: .categories, items: items)
    }
}
