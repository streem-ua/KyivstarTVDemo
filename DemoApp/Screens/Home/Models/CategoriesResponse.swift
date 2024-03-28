//
//  CategoriesResponse.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable, Hashable {
    let id, name: String
    let image: String
}
