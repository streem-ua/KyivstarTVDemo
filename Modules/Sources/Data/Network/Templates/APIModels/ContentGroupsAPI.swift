//
//  ContentGroupsAPI.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - ContentGroupsAPI
struct ContentGroupsAPI: Codable {
    let id, name: String
    let type: [String]
    let assets: [AssetAPI]
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool
}

// MARK: - Asset
struct AssetAPI: Codable {
    let id, name: String
    let image: String
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
    let updatedAt, releaseDate: String
}
