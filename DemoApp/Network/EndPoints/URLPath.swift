//
//  URLPath.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

struct URLPath {
    enum Home: PURLPath {
        case contentGroup
        case promotions
        case category
        var link: String {
            switch self {
            case .contentGroup:
                "PGgg02gplft-/data"
            case .promotions:
                "j_BRMrbcY-5W/data"
            case .category:
                "eO-fawoGqaNB/data"
            }
        }
    }
    enum Details: PURLPath {
        case assetDetails
        var link: String { "04Pl5AYhO6-n/data" }
    }
}
