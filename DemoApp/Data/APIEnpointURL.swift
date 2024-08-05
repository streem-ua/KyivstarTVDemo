//
//  RequestURL.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import Foundation

struct APIEnpointURL {
    static func getContentGroups() -> URL {
        return URL(string: "\(Environment.hostAddress)/templates/PGgg02gplft-/data")!
    }
    
    static func getPromotionsURL() -> URL {
        return URL(string: "\(Environment.hostAddress)/templates/j_BRMrbcY-5W/data")!
    }
    
    static func getCategoriesURL() -> URL {
        return URL(string: "\(Environment.hostAddress)/templates/eO-fawoGqaNB/data")!
    }
    
    static func getAssetDetailsURL() -> URL {
        return URL(string: "\(Environment.hostAddress)/templates/04Pl5AYhO6-n/data")!
    }
}
