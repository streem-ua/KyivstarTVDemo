//
//  ConectGroup.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import Foundation

typealias ContentGroups = [ContentGroup]
typealias GroupAssets = [ContentGroupAsset]

struct ContentGroup: Decodable {
    let id: String
    let name: String
    let type: [ContentGroupType]
    let assets: GroupAssets
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool
    
    var specificType: ContentGroupType {
        type.first ?? .nonUsed
    }
}

struct ContentGroupAsset: Decodable, Hashable {
    let id: String
    let name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
    let updatedAt: String
    let releaseDate: String
    
    var floatProgress: CGFloat {
        CGFloat(progress)/CGFloat(100)
    }
}

enum ContentGroupType: String, Decodable {
    case MOVIE = "MOVIE"
    case SERIES = "SERIES"
    case LIVECHANNEL = "LIVECHANNEL"
    case EPG = "EPG"
    case nonUsed
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        guard let value = ContentGroupType(rawValue: value) else {
            self = .nonUsed
            return
        }
        self = value
    }
}

extension ContentGroups {
    func homeSectionModels() -> [HomeSectionModel] {
        let filteredGroups = compactMap {$0.specificType != .nonUsed ? $0 : nil}
        var movie = HomeSectionModel(section: .movie, items: [])
        var epg = HomeSectionModel(section: .epg, items: [])
        var livechannel = HomeSectionModel(section: .livechannel, items: [])
        
        filteredGroups.forEach { group in
            switch group.specificType {
            case .MOVIE, .SERIES:
                let assets = group.assets.map {Home.Item.movie($0)}
                movie.items += assets
            case .LIVECHANNEL:
                let assets = group.assets.map {Home.Item.livechannel($0)}
                livechannel.items += assets
            case .EPG:
                let assets = group.assets.map {Home.Item.epg($0)}
                epg.items += assets
            case .nonUsed:
                break
            }
        }
 
        return [movie, livechannel, epg]
    }
}

struct HomeSectionModel {
    let section: Home.Section
    var items: [Home.Item]
}

//struct ContentGroupAssetTestModel {
//    let canBeDeleted: Bool = true
//    let asset: ContentGroupAsset
//}
