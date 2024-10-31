//
//  HomeServiceProvider.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 20.10.2024.
//

import Foundation

enum HomeServiceProvider {
    case getContentGroups
    case getPromotions
    case getCategories
    case getAssetDetails
}

extension HomeServiceProvider: ApiEndpoint {

    var baseURLString: String {
        return APIConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getContentGroups:
            return "templates/PGgg02gplft-"
        case .getPromotions:
            return "templates/j_BRMrbcY-5W"
        case .getCategories:
            return "templates/eO-fawoGqaNB"
        case .getAssetDetails:
            return "templates/04Pl5AYhO6-n"
        }
    }

    var suffix: String {
        return "data"
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var method: APIHTTPMethod {
        return .GET
    }
}
