//
//  ContentGroupsResponse.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

typealias ContentGroupsResponse = [ContentGroup]

// MARK: - ContentGroupsResponseElement
struct ContentGroup: Codable {
    let id, name: String
    let type: [ContentType]
    let assets: [Asset]
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool

    enum ContentType: String, Codable {
        case movie = "MOVIE"
        case series = "SERIES"
        case liveChannel = "LIVECHANNEL"
        case epg = "EPG"
        case unknown

        init(rawValue: String) {
            switch rawValue {
            case "MOVIE": self = .movie
            case "SERIES": self = .series
            case "LIVECHANNEL": self = .liveChannel
            case "EPG": self = .epg
            default: self = .unknown
            }
        }
    }
}

// MARK: - Asset
struct Asset: Codable, Hashable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
    let updatedAt, releaseDate: String
}
