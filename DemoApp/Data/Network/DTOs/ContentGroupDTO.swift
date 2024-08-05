//
//  ContentGroupsResponseDTO.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

struct ContentGroupDTO : Decodable {
    let id : String
    let name : String
    let type : [String]
    let assets : [AssetDTO]
    let hidden : Bool
    let sortIndex : Int
    let canBeDeleted : Bool
}

extension ContentGroupDTO {
    struct AssetDTO : Decodable {
        let id : String
        let name : String
        let image : String
        let company : String
        let progress : Int
        let purchased : Bool
        let sortIndex : Int
        let updatedAt : String
        let releaseDate : String
    }
}
