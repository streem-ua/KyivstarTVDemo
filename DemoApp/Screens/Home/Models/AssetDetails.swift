//
//  AssetDetails.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

// MARK: - AssetDetails
struct AssetDetails: Codable {
    let id: String
    let name: String
    let image: String
    let company: String
    let similar: [SimilarAsset]
    let duration, progress: Int
    let purchased: Bool
    let updatedAt, description, releaseDate: String
}

// MARK: - Similar
struct SimilarAsset: Codable, Identifiable {
    let id: String
    let name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let updatedAt: String
    let releaseDate: String
}

