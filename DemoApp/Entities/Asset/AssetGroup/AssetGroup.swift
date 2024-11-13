//
//  AssetGroup.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

struct AssetGroup: Identifiable {
    let id: String
    let name: String
    let type: [ContentType]
    let assets: [Asset]
}

extension AssetGroup {
    enum ContentType: String, Decodable, Equatable {
        case epg = "EPG"
        case livechannel = "LIVECHANNEL"
        case movies = "MOVIE"
        case series = "SERIES"
    }
}

extension Array where Element == AssetGroup {
    // MARK: - Properties
    var moviesOrSeries: [Asset] {
        getAssetsWithPredicate { $0 == .movies || $0 == .series }
    }
    
    var epgs: [Asset] {
        getAssetsWithPredicate { $0 == .epg }
    }
    
    var livechannels: [Asset] {
        getAssetsWithPredicate { $0 == .livechannel }
    }
    
    // MARK: - Helpers
    private func getAssetsWithPredicate(_ predicate: (Element.ContentType) -> Bool) -> [Asset] {
        filter {
            $0.type.contains(where: predicate)
        }
        .map(\.assets)
        .joined()
        .toArray()
    }
}
