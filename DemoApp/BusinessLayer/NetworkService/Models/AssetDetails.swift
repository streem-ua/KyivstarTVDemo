//
//  AssetDetails.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 03.06.2024.
//

import Foundation

struct AssetDetails: Decodable {
    let id: String
    let name: String
    let image: String
    let company: String
    let similar: [Similar]
    let duration: Int
    let progress: Int
    let purchased: Bool
    let updatedAt: String
    let description: String
    let releaseDate: String
    
    var floatProgress: CGFloat {
        CGFloat(progress)/CGFloat(100)
    }
}

struct Similar: Decodable {
    let id: String
    let name: String
    let image: String
    let progress: Int
    let company: String
    let updatedAt: String
    let releaseDate: String
    let purchased: Bool
}
