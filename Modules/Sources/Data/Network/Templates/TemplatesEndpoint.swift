//
//  TemplatesEndpoint.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

enum TemplatesEndpoint: Endpoint {
    
    case getContentGroups
    case getPromotions
    case getCategories
    case getAssetDetails
    
    var path: String {
        switch self {
        case .getContentGroups:
            "/templates/PGgg02gplft-/data"
        case .getPromotions:
            "templates/j_BRMrbcY-5W/data"
        case .getCategories:
            "templates/eO-fawoGqaNB/data"
        case .getAssetDetails:
            "templates/04Pl5AYhO6-n/data"
        }
    }
    
    var method: ApiMethod {
        return .get
    }
}
