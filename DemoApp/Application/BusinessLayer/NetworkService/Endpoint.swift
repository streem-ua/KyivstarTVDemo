//
//  NetworkAPI.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import Foundation

enum Endpoint {
    case contentGroups
    case promotions
    case categories
    case assetDetails
}

fileprivate let bearer = "vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"

extension Endpoint: TargetType {
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.json-generator.com"
    }
    
    var path: String {
        switch self {
        case .contentGroups:
            return "/templates/PGgg02gplft-/data"
        case .promotions:
            return "/templates/j_BRMrbcY-5W/data"
        case .categories:
            return "/templates/eO-fawoGqaNB/data"
        case .assetDetails:
            return "/templates/04Pl5AYhO6-n/data/"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        .GET
    }
    
    var parameters: [String : Any] {
        [:]
    }
    
    var headers: [String : String] {
        ["Authorization":"Bearer \(bearer)"]
    }
}





