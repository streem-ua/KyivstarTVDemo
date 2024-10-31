//
//  AssetDetailsResponseModel.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation

typealias AssetDetailsResponseModel = AssetDetails

struct AssetDetails: Codable {
    let id, name: String
    let image: String
    let company: String
    let similar: [Similar]
    let duration, progress: Int
    let purchased: Bool
    let updatedAt, description, releaseDate: String
}

struct Similar: Codable, Identifiable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let updatedAt, releaseDate: String
}
