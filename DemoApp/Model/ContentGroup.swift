//
//  ContentGroup.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import Foundation

struct ContentGroup: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let type: [String]
    let assets: [Asset]
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool
}

struct Asset: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let image: URL
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
}
