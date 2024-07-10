//
//  ContentGroup.swift
//  DemoApp
//
//  Created by Nik Dub on 09.07.2024.
//

import Foundation

// MARK: - ContentGroup -

struct ContentGroup: Codable {
    let id, name: String
    let type: [String]
    let assets: [Asset]
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool
}

// MARK: - Asset -

struct Asset: Codable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
    let updatedAt, releaseDate: String
}
