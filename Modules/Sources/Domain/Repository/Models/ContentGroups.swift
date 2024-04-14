//
//  ContentGroups.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

public enum ContentType: String {
    case movie = "MOVIE"
    case series = "SERIES"
    case liveChannel = "LIVECHANNEL"
    case epg = "EPG"
    case unknown
}

// MARK: - ContentGroups
public struct ContentGroups {
    public let id, name: String
    public let type: [ContentType]
    public let assets: [Asset]
    public let hidden: Bool
    public let sortIndex: Int
    public let canBeDeleted: Bool
}

extension ContentGroupsAPI {
    func mapToDoamin() -> ContentGroups {
        let typeDomain = type.map { ContentType(rawValue: $0) ?? .unknown }
        return ContentGroups(id: id,
                                   name: name,
                                   type: typeDomain,
                                   assets: assets.map { $0.mapToDoamin() },
                                   hidden: hidden,
                                   sortIndex: sortIndex,
                                   canBeDeleted: canBeDeleted)
    }
}

// MARK: - Asset
public struct Asset: Hashable {
    public let id, name: String
    public let image: String
    public let company: String
    public let progress: Int
    public let purchased: Bool
    public let sortIndex: Int
    public let updatedAt, releaseDate: String
    
    public static var mock: Asset = {
        Asset(id: "1",
              name: "The Falcon and the Winter Soldier",
              image: "https://picsum.photos/id/991/400/600",
              company: "Marvel Studios",
              progress: 0,
              purchased: false,
              sortIndex: 0,
              updatedAt: "2021-03-19T16:00:00Z",
              releaseDate: "2021-03-19T16:00:00Z")
    }()
}

extension AssetAPI {
    
    func mapToDoamin() -> Asset {
        return Asset(id: id,
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
