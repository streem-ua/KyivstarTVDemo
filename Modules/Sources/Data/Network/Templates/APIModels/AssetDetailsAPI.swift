//
//  AssetDetailsAPI.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - AssetDetailsAPI
struct AssetDetailsAPI: Codable {
    let id, name: String
    let image: String
    let company: String
    let similar: [SimilarAssetAPI]
    let duration, progress: Int
    let purchased: Bool
    let updatedAt, description, releaseDate: String
}

// MARK: - SimilarAssetAPI
struct SimilarAssetAPI: Codable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let updatedAt, releaseDate: String
}

