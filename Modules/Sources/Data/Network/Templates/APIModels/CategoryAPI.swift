//
//  CategoryAPI.swift
//  
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - CategoriesAPI
public struct CategoriesAPI: Codable {
    public let categories: [CategoryAPI]
}

// MARK: - CategoryAPI
public struct CategoryAPI: Codable {
    public let id, name: String
    public let image: String
}
