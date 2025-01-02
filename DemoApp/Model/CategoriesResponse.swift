//
//  CategoriesResponse.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [Category]
}

struct Category: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let image: String
}
