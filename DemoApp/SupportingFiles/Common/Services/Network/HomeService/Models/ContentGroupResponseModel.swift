//
//  ContentGroupResponseModel.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation

typealias ContentGroupResponseModel = [ContentGroup]

struct ContentGroup: Codable {
    let id: String
    let name: String
    let type: [ContentType]
    let assets: [Asset]
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool
}

struct Asset: Codable, Hashable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
    let updatedAt: String
    let releaseDate: String
}

enum ContentType: String, Codable {
    case livechannel = "LIVECHANNEL"
    case series = "SERIES"
    case epg = "EPG"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        if let type = ContentType(rawValue: rawValue) {
            self = type
        } else {
            self = .unknown
        }
    }
}
