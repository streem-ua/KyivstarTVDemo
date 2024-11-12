//
//  Category.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

struct CategoryModel: Codable, Hashable {
    let categories: [Category]?
}

struct Category: Codable, Hashable {
    let id: String
    let name: String?
    let image: String?
}
