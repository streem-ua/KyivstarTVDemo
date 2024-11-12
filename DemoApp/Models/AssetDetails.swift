//
//  AssetDetails.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

struct AssetDetails: Codable {
    let id: String
    let name: String
    let description: String
    let image: String?
    let genre: String?
    let duration: Int?
    let releaseDate: String?
    let isPurchased: Bool?
    let similar: [ContentGroup.Asset]?
}

extension AssetDetails {
    var title: String {
        name.isEmpty ? "The SpongeBob Movie: Sponge on the Run" : name
    }
    var assetSubtitle: String {
        let genreText = genre ?? "Adventure"
        let durationText = duration?.formattedDuration() ?? ""
        let releaseYear = releaseDate?.releaseYear() ?? ""
        return "\(genreText) • \(durationText) • \(releaseYear)"
    }
}
