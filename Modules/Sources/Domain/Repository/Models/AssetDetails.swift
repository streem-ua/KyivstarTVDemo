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
    public let id, name: String
    public let imageURL: URL?
    public let company: String
    public let similar: [SimilarAsset]
    public let duration, progress: Int
    public let purchased: Bool
    public let updatedAt, description, releaseDate: String
}

extension AssetDetailsAPI {
    
    func mapToDoamin() -> AssetDetails {
        let imageURL = URL(string: image)
        return AssetDetails(id: id,
                                  name: name,
                                  imageURL: imageURL,
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
public struct SimilarAsset: Hashable {
    public let id, name: String
    public let imageURL: URL?
    public let company: String
    public let progress: Int
    public let purchased: Bool
    public let updatedAt, releaseDate: String
}

extension SimilarAssetAPI {
    func mapToDoamin() -> SimilarAsset {
        let imageURL = URL(string: image)
        return SimilarAsset(id: id,
                                  name: name,
                                  imageURL: imageURL,
                                  company: company,
                                  progress: progress,
                                  purchased: purchased,
                                  updatedAt: updatedAt,
                                  releaseDate: releaseDate)
    }
}


