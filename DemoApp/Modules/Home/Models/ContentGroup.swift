//
//  ContentGroupsModel.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation

struct ContentGroup: Decodable, Hashable {
  
    struct Asset : Decodable, Hashable {
        let id: String
        let name: String
        let image: String
        let company: String
        let progress: Int
        let purchased: Bool
        let sortIndex: Int?
        let updatedAt: String
        let releaseDate: String
    }
    
    enum GroupType: String, Decodable, Hashable {
        case epg = "EPG"
        case noNeedToDiaplay = "NO_NEED_TO_DISPLAY"
        case series = "SERIES"
        case movie = "MOVIE"
        case liveChannels = "LIVECHANNEL"
    }
    
    let id: String
    let name: String
    let type: [GroupType]
    let assets: [Asset]
    let hidden: Bool
    let canBeDeleted: Bool
}


