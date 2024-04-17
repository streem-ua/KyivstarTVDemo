//
//  AssetDetailsAPI.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - AssetDetailsAPI
public struct AssetDetailsAPI: Codable {
    public let id, name: String
    public let image: String
    public let company: String
    public let similar: [SimilarAssetAPI]
    public let duration, progress: Int
    public let purchased: Bool
    public let updatedAt, description, releaseDate: String
}

// MARK: - SimilarAssetAPI
public struct SimilarAssetAPI: Codable {
    public let id, name: String
    public let image: String
    public let company: String
    public let progress: Int
    public let purchased: Bool
    public let updatedAt, releaseDate: String
}

