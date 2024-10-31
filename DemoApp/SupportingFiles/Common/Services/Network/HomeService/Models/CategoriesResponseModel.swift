//
//  CategoriesResponseModel.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation

struct CategoriesResponseModel: Codable {
    let categories: [Category]
}

struct Category: Codable, Hashable {
    let id, name: String
    let image: String
}
