//
//  Asset.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

struct Asset: Equatable, Hashable, Identifiable {
    let id: String
    let name: String
    let image: URL
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
    let updatedAt: Date
    let releaseDate: Date
}
