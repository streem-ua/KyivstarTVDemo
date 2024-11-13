//
//  AssetDetailsResponseDTO.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

struct AssetDetailsResponseDTO: Decodable {
    let id : String
    let name : String
    let image : String
    let company : String
    let similar : [SimilarDTO]
    let duration : Int
    let progress : Int
    let purchased : Bool
    let updatedAt : String
    let description : String
    let releaseDate : String
}

extension AssetDetailsResponseDTO {
    struct SimilarDTO : Codable {
        let id : String
        let name : String
        let image : String
        let company : String
        let progress : Int
        let purchased : Bool
        let updatedAt : String
        let releaseDate : String
    }    
}
