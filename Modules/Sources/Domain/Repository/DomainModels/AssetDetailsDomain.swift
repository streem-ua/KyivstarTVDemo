//
//  AssetDetailsDomain.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - AssetDetailsDomain
public struct AssetDetailsDomain {
    let id, name: String
    let image: String
    let company: String
    let similar: [SimilarAssetDomain]
    let duration, progress: Int
    let purchased: Bool
    let updatedAt, description, releaseDate: String
}

extension AssetDetailsAPI {
    
    func mapToDoamin() -> AssetDetailsDomain {
        return AssetDetailsDomain(id: id,
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

// MARK: - AssetDetailsDomain
struct SimilarAssetDomain: Codable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let updatedAt, releaseDate: String
}

extension SimilarAssetAPI {
    func mapToDoamin() -> SimilarAssetDomain {
        return SimilarAssetDomain(id: id,
                                  name: name,
                                  image: image,
                                  company: company,
                                  progress: progress,
                                  purchased: purchased,
                                  updatedAt: updatedAt,
                                  releaseDate: releaseDate)
    }
}


