//
//  SimilarAssetResponse.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import Foundation

struct SimilarAssetResponse: Codable {
    let similar: [SimilarAsset]
}

struct SimilarAsset: Identifiable, Codable {
    var id: String
    var name: String
    var image: String
    var purchased: Bool
}
