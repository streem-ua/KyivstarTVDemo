//
//  ContentGroup.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

struct ContentGroup: Codable, Hashable {
    let id: String?
    let name: String?
    let type: [ContentType]
    let assets: [Asset]?
    let hidden: Bool?
    let sortIndex: Int?
    let canBeDeleted: Bool?
    
    enum ContentType: String, Codable, Hashable {
        case movie = "MOVIE"
        case series = "SERIES"
        case liveChannel = "LIVECHANNEL"
        case epg = "EPG"
        case noNeedToDisplay = "NO_NEED_TO_DISPLAY"
    }
    
    struct Asset: Codable, Identifiable, Hashable {
        let id: String?
        let name: String?
        let image: String?
        let company: String?
        let progress: Double?
        let purchased: Bool?
        let sortIndex: Int?
        let updatedAt: String?
        let releaseDate: String?
    }
}

extension ContentGroup.Asset {
    var epgSubtitle: String { "У записі • Телеканал \(company ?? "")" }
}
