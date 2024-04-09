//
//  ContentGroupsDomain.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - ContentGroupsDomain
public struct ContentGroupsDomain {
    public let id, name: String
    public let type: [String]
    public let assets: [AssetDomain]
    public let hidden: Bool
    public let sortIndex: Int
    public let canBeDeleted: Bool
}

extension ContentGroupsAPI {
    func mapToDoamin() -> ContentGroupsDomain {
        return ContentGroupsDomain(id: id,
                                   name: name,
                                   type: type,
                                   assets: assets.map { $0.mapToDoamin() },
                                   hidden: hidden,
                                   sortIndex: sortIndex,
                                   canBeDeleted: canBeDeleted)
    }
}

// MARK: - AssetDomain
public struct AssetDomain: Codable {
    public let id, name: String
    public let image: String
    public let company: String
    public let progress: Int
    public let purchased: Bool
    public let sortIndex: Int
    public let updatedAt, releaseDate: String
}

extension AssetAPI {
    
    func mapToDoamin() -> AssetDomain {
        return AssetDomain(id: id,
                           name: name,
                           image: image,
                           company: company,
                           progress: progress,
                           purchased: purchased,
                           sortIndex: sortIndex,
                           updatedAt: updatedAt,
                           releaseDate: releaseDate)
    }
}
