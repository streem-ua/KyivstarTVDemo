//
//  AssetDetails.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - AssetDetails
public struct AssetDetails: Hashable {
    let id, name: String
    let image: String
    let company: String
    let similar: [SimilarAsset]
    let duration, progress: Int
    let purchased: Bool
    let updatedAt, description, releaseDate: String
}

extension AssetDetailsAPI {
    
    func mapToDoamin() -> AssetDetails {
        return AssetDetails(id: id,
                                  name: name,
                                  image: image,
                                  company: company,
                                  similar: similar.map { $0.mapToDoamin() },
                                  duration: duration,
                                  progress: progress,
                                  purchased: purchased,
                                  updatedAt: updatedAt,
                                  description: description,
                                  releaseDate: releaseDate)
    }
}

// MARK: - AssetDetails
struct SimilarAsset: Hashable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let updatedAt, releaseDate: String
}

extension SimilarAssetAPI {
    func mapToDoamin() -> SimilarAsset {
        return SimilarAsset(id: id,
                                  name: name,
                                  image: image,
                                  company: company,
                                  progress: progress,
                                  purchased: purchased,
                                  updatedAt: updatedAt,
                                  releaseDate: releaseDate)
    }
}


